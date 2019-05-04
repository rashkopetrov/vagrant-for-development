Listen {{HTTP_PORT}}

<IfModule ssl_module>
    Listen {{HTTPS_PORT}}
</IfModule>

<IfModule mod_gnutls.c>
    Listen {{HTTPS_PORT}}
</IfModule>

<VirtualHost *:{{HTTP_PORT}}>
    ServerName {{SERVER_NAME}}

    ServerAdmin webmaster@localhost
    DocumentRoot /usr/local/nagios/share

    DirectoryIndex index.php index.html index.htm index.shtml

    <Proxy "unix:/var/run/php/php7.2-fpm.sock|fcgi://php-fpm">
        ProxySet disablereuse=off
    </Proxy>

    <FilesMatch \.php$>
        SetHandler proxy:fcgi://php-fpm
    </FilesMatch>

    # SAMPLE CONFIG SNIPPETS FOR APACHE WEB SERVER
    #
    # This file contains examples of entries that need
    # to be incorporated into your Apache web server
    # configuration file.  Customize the paths, etc. as
    # needed to fit your system.

    ScriptAlias /nagios/cgi-bin "/usr/local/nagios/sbin"

    <Directory "/usr/local/nagios/sbin">
        # SSLRequireSSL
        Options ExecCGI
        AllowOverride None

        <IfVersion >= 2.3>
            <RequireAll>
                Require all granted
                # Require host 127.0.0.1

                AuthName "Nagios Access"
                AuthType Basic
                AuthUserFile /usr/local/nagios/etc/htpasswd.users
                Require valid-user
            </RequireAll>
        </IfVersion>

        <IfVersion < 2.3>
            Order allow,deny
            Allow from all
            # Order deny,allow
            # Deny from all
            # Allow from 127.0.0.1

            AuthName "Nagios Access"
            AuthType Basic
            AuthUserFile /usr/local/nagios/etc/htpasswd.users
            Require valid-user
        </IfVersion>
    </Directory>

    Alias /admin "/usr/local/nagios/share"

    <Directory "/usr/local/nagios/share">
        # SSLRequireSSL
        Options None
        AllowOverride None

        <IfVersion >= 2.3>
            <RequireAll>
                Require all granted
                # Require host 127.0.0.1

                AuthName "Nagios Access"
                AuthType Basic
                AuthUserFile /usr/local/nagios/etc/htpasswd.users
                Require valid-user
            </RequireAll>
        </IfVersion>

        <IfVersion < 2.3>
            Order allow,deny
            Allow from all
            # Order deny,allow
            # Deny from all
            # Allow from 127.0.0.1

            AuthName "Nagios Access"
            AuthType Basic
            AuthUserFile /usr/local/nagios/etc/htpasswd.users
            Require valid-user
        </IfVersion>
    </Directory>
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
