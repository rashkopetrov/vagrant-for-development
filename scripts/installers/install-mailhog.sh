#!/usr/bin/env bash

# Check If Mailhog Has Been Installed
if [ -f /home/vagrant/.installed-mailhog ]
then
    echo "Mailhog already installed."
    exit 0
fi

touch /home/vagrant/.installed-mailhog

mkdir ~/gocode
echo "export GOPATH=$HOME/gocode" >> ~/.profile
source ~/.profile
go get github.com/mailhog/MailHog
go get github.com/mailhog/mhsendmail
cp ~/gocode/bin/MailHog /usr/local/bin/mailhog
cp ~/gocode/bin/mhsendmail /usr/local/bin/mhsendmail

echo "
[Unit]
Description=MailHog service

[Service]
ExecStart=/usr/local/bin/mailhog \
  -api-bind-addr 127.0.0.1:2025 \
  -ui-bind-addr 127.0.0.1:2025 \
  -smtp-bind-addr 127.0.0.1:2026

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/mailhog.service

systemctl start mailhog
systemctl enable mailhog
