<VirtualHost *:{{HTTP_PORT}}>
    ServerName {{SERVER_NAME}}

    ServerAdmin webmaster@localhost
    DocumentRoot {{SERVER_ROOT}}

    DirectoryIndex index.php index.html index.htm index.shtml

    <Directory "{{SERVER_ROOT}}">
        Options FollowSymLinks
        AllowOverride All

        Order allow,deny
        Allow from all
    </Directory>

    <Proxy "unix:/var/run/php/php7.2-fpm.sock|fcgi://php-fpm">
        ProxySet disablereuse=off
    </Proxy>

    <FilesMatch \.php$>
        SetHandler proxy:fcgi://php-fpm
    </FilesMatch>
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
