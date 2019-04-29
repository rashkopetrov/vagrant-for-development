<VirtualHost *:{{HTTP_PORT}}>
    ServerName {{SERVER_NAME}}

    ServerAdmin webmaster@localhost
    DocumentRoot {{SERVER_ROOT}}

    <Directory "{{SERVER_ROOT}}">
        Options FollowSymLinks
        AllowOverride All

        Order allow,deny
        Allow from all
    </Directory>
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
