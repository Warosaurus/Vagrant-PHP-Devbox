#!/usr/bin/env bash

# Env variables
# MySQL password
mypass=$(sed '1q;d' /vagrant/conf/.auth)
debconf-set-selections <<< "mysql-server mysql-server/root_password password "$mypass
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password "$mypass

# Update sources list
apt-get update

#dpkg --configure -a

# Install Apache
apt-get install -y apache2

# Set server name for Apache
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf

# Install php and mods
apt-get install -y php5 php5-cli libapache2-mod-php5

# Install mysql and mods
apt-get install -f -y mysql-common mysql-server 

# Install mysql mods
apt-get install -y libapache2-mod-auth-mysql php5-mysql

# Install this thing
apt-get install -f -y libmcrypt4 php5-mcrypt



# Enable stuff
a2enmod rewrite
a2enmod php5
a2enconf fqdn

# Set up Apache
# Back up old config
cp /etc/apache2/mods-enabled/dir.conf /etc/apache2/mods-enabled/dir.conf.bak
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak

# Insert modified config
cp /vagrant/conf/000-default.conf /etc/apache2/sites-available/000-default.conf
cp /vagrant/conf/dir.conf /etc/apache2/mods-enabled/dir.conf

# Restart services
service apache2 restart
service mysql restart