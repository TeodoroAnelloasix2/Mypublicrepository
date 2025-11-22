#!/bin/bash
sed  -i -e '/{restart}/ s/i/l/' -e '/{restart}/ s/^#//' /etc/needrestart/needrestart.conf

DEBIAN_FRONTEND="noninteractive"

apt -qq update
apt -qq install -y apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip \
                 pwgen
                 
WORDPRESS_DOMAIN=demo-wordpress-$(pwgen -1 -s 8)

# el nom de la base de dades no pot tindre "-" (crec)
WORDPRESS_DB=wp_demo
WORDPRESS_USER=wp_demo_user
WORDPRESS_USER_PASS=$(pwgen -1 -s 16)


mkdir -p /srv/www

echo $WORDPRESS_DOMAIN | tee -a /srv/wp-init
echo $WORDPRESS_USER_PASS | tee -a /srv/wp-init

chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

tee /etc/apache2/sites-available/wordpress.conf << EOF
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF

a2ensite wordpress
a2enmod rewrite
a2enmod ssl
a2dissite 000-default
service apache2 reload

tee configura-db.sql << EOF
CREATE DATABASE $WORDPRESS_DB;
CREATE USER $WORDPRESS_USER@'localhost' 
IDENTIFIED BY '$WORDPRESS_USER_PASS';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER 
ON $WORDPRESS_DB.* 
TO $WORDPRESS_USER@localhost;
FLUSH PRIVILEGES;
EOF

# cat configura-db.sql | sudo mysql --defaults-extra-file=/etc/mysql/debian.cnf
cat configura-db.sql | mysql  -u root

sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i 's/database_name_here/'"$WORDPRESS_DB"'/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/'"$WORDPRESS_USER"'/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/'"$WORDPRESS_USER_PASS"'/' /srv/www/wordpress/wp-config.php


#sudo -u www-data nano /srv/www/wordpress/wp-config.php
sed -i "/'AUTH_KEY'/ s/'put your unique phrase here'/'flipant07'/"  /srv/www/wordpress/wp-config.php
sed -i "/'SECURE_AUTH_KEY'/ s/'put your unique phrase here'/'flipant08'/"  /srv/www/wordpress/wp-config.php
sed -i "/'LOGGED_IN_KEY'/ s/'put your unique phrase here'/'flipant04'/"  /srv/www/wordpress/wp-config.php
sed -i "/'NONCE_KEY'/ s/'put your unique phrase here'/'flipant01'/"  /srv/www/wordpress/wp-config.php
sed -i "/'AUTH_SALT'/ s/'put your unique phrase here'/'flipant06'/"  /srv/www/wordpress/wp-config.php
sed -i "/'SECURE_AUTH_SALT'/ s/'put your unique phrase here'/'flipant05'/"  /srv/www/wordpress/wp-config.php
sed -i "/'LOGGED_IN_SALT'/ s/'put your unique phrase here'/'flipant03'/"  /srv/www/wordpress/wp-config.php
sed -i "/'NONCE_SALT'/ s/'put your unique phrase here'/'flipant02'/"  /srv/www/wordpress/wp-config.php


snap install certbot --classic
#sudo certbot --apache -d asix2a.duckdns.org
#### sudo certbot --apache -n --agree-tos --redirect --hsts --uir --staple-ocsp  --register-unsafely-without-email -d $WORDPRESS_DOMAIN,www.$WORDPRESS_DOMAIN

