#!/usr/bin/env bash

# Check If Mailhog Has Been Installed
if [ -f /home/vagrant/.installed-mailhog ]
then
    echo "Mailhog already installed."
    exit 0
fi

echo "Installing Mailhog"

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
  -hostname 0.0.0.0 \
  -api-bind-addr 0.0.0.0:8025 \
  -ui-bind-addr 0.0.0.0:8025 \
  -smtp-bind-addr 0.0.0.0:1025

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/mailhog.service

systemctl start mailhog
systemctl enable mailhog

sed -i "s/relayhost =/#relayhost =/g" /etc/postfix/main.cf
echo "
# For MailHog
myhostname = localhost
relayhost = [localhost]:1025
" >> /etc/postfix/main.cf

service postfix stop
service postfix start

echo "Message Body" | mail -s "Message Subject" receiver@example.com
