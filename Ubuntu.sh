#!/bin/bash
# Redis
sudo apt-get update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:redislabs/redis
sudo apt-get update
sudo apt-get install -y redis
# Logs--------
sudo mkdir -p /root/tasks/1/
dpkg-query -L redis-server > /root/tasks/1/packagefileslist
cat /root/tasks/1/packagefileslist
dpkg -S /etc/sysctl.conf > /root/tasks/1/filetopackagename
cat /root/tasks/1/filetopackagename
# Git
sudo apt update
sudo apt install -y build-essential libssl-dev libcurl4-gnutls-dev libz-dev zlib1g-dev libexpat1-dev gettext unzip
cd /usr/local/src
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.34.1.tar.gz
tar xzf git-2.34.1.tar.gz
cd git-2.34.1
make prefix=/usr/local/sbin all
make prefix=/usr/local/sbin install
echo "export PATH=$PATH:/usr/local/sbin" >> /etc/bashrc
source /etc/bashrc
git --version
# Disk add
# df -h, lsblk
# fdisk -l, fdisk /dev/disk, mkfs.ext4 /dev/disk
# mkdir /data, mount /dev/nvme1n1p1 /data
# sudo blkid
# sudo nano /etc/fstab
# symlink ln -s /data/mysql /var/lib/mysql    ln -s /data/www /var/www (проверить - ls -l /var/lib/mysql ls -l /var/www)
# created swap file - sudo fallocate -l 1G /swap - sudo mkswap /swap - sudo chmod 600 /swap - sudo swapon /swap - sudo nano /etc/fstab > /swap none swap defaults 0 0
# -----------------Установка NGINX----------------------
sudo apt update
sudo apt upgrade
apt install net-tools
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-archive-keyring
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
gpg --dry-run --quiet --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
        | sudo tee /etc/apt/sources.list.d/nginx.list
sudo apt update
sudo apt install nginx
sudo ln -s /etc/nginx/sites-available/wordpress.example.com.conf /etc/nginx/sites-enabled/
# systemctl start nginx
# systemctl enable nginx
# systemctl status nginx
# /etc/nginx/conf.d/
#-----------------Установка MYSQL-------------------------#
# cd /tmp
wget https://dev.mysql.com/get/mysql-apt-config_0.8.20-1_all.deb
# sudo dpkg -i mysql-apt-config_0.8.20-1_all.deb - or
sudo apt install ./mysql-apt-config_0.8.20-1_all.deb
sudo sed -i 's/xenial/focal/g' /etc/apt/sources.list.d/mysql.list
sudo apt update
sudo apt install mysql-server
#3-----------------------или-----------------------#
wget –c https://dev.mysql.com/get/mysql-apt-config_0.8.20-1_all.deb
sudo apt-get update
sudo apt-get install mysql-server
# /etc/ my.cnf > bind-address=127.0.0.1
 # sudo mysql_secure_installation
# systemctl start mysql
  # systemctl enable mysql
# systemctl status mysql

#---------------Установка--APACHE-----------------------------------#
# sudo apt update
# sudo apt install apache2
# systemctl start apache2
# systemctl enable apache2
# systemctl status apache2
# systemctl restart apache2
#Все настройки содержатся в папке /etc/apache2/:
# /etc/apache2/apache2.conf отвечает за основные настройки
# /etc/apache2/conf-available/* - дополнительные настройки веб-сервера
# /etc/apache2/mods-available/* - настройки модулей
# /etc/apache2/sites-available/* - настойки виртуальных хостов
# /etc/apache2/ports.conf - порты, на которых работает apache
# /etc/apache2/envvars

#---------------Установка--PHP8-----------------------------------#
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.0 libapache2-mod-php8.0
sudo apt install php8.0 php8.0-cli php8.0-fpm  php8.0-pdo php8.0-mysql php8.0-zip php8.0-gd php8.0-mbstring php8.0-curl php8.0-xml php-pear php8.0-bcmath
mkdir -p /var/lib/php/sessions
chown -R nginx:nginx /var/lib/php/sessions
chmod -R 755 /var/lib/php/sessions
#---------------Установка--PHP8-FPM---------------------------------#
sudo apt update
# sudo systemctl status php8.0-fpm
# systemctl enable php8.0-fpm
# useradd php-fpm
# systemctl status php8.0-fpm
# /etc/php/8.0/fpm/php-fpm.conf
# /etc/php/8.0/fpm/pool.d/www.conf
# -------------------УСТАНОВКА PURE-FTPD---------------------
apt-get update -y
apt install ftp
apt-get install pure-ftpd -y
# systemctl status pure-ftpd
# systemctl enable pure-ftpd
# systemctl start pure-ftpd
cd /etc/pure-ftpd
nano /etc/pure-ftpd/pure-ftpd.conf > PassivePortRange 45000 50000 > PureDB /etc/pure-ftpd/pureftpd.pdb
ftp -p -d 10.112.2.125
netstat -tnulp | grep pure-ftpd
# ПОЛЬЗОВАТЕЛЬ WORDPRESS---------------------------
# sudo groupadd ftpusers
sudo chown -R php-fpm:php-fpm /var/www/wordpress.example.com
sudo chown -R :php-fpm /var/www/wordpress.example.com/wp-content/uploads
sudo chmod -R g+w /var/www/wordpress.example.com/wp-content/uploads
# useradd wordpress
# sudo gpasswd -a wordpress ftpusers
sudo chown php-fpm:php-fpm /var/www/wordpress.example.com/wp-content/uploads -R
chmod -R 755 /var/www/wordpress.example.com/wp-content/uploads
# sudo pure-pw useradd wordpress -u php-fpm -g php-fpm -d /var/www/wordpress.example.com/wp-content/uploads -m
sudo pure-pw useradd wordpress -u php-fpm -g php-fpm -d /var/www/wordpress.example.com -m
sudo pure-pw mkdb
sudo systemctl restart pure-ftpd
sudo pure-pw show wordpress
ftp -p -d 10.112.2.125
netstat -tnulp | grep pure-ftpd
# sudo pure-pw passwd - смена пароля
# sudo pure-ftpwho - простмотр активности

# ПОЛЬЗОВАТЕЛЬ DRUPAL---------------------------
#sudo chown -R :apache /var/www/drupal.example.com/sites/default/files
#sudo chmod -R g+w /var/www/drupal.example.com/sites/default/files
# sudo gpasswd -a drupal ftpusers1
#sudo chown apache:apache /var/www/drupal.example.com/sites/default/files -R
#sudo pure-pw useradd drupal -u apache -g apache -d /var/www/drupal.example.com/sites/default/files -m
# sudo pure-pw useradd drupal -u apache -g apache -d /var/www/drupal.example.com -m
#sudo pure-pw mkdb
#sudo systemctl restart pure-ftpd
#sudo pure-pw show drupal
#more /var/log/messages | grep pure-ftpd   -  посмотреть ЛОГИ!!!!!
# pure-pw userdel -удаление пользователя
# Settings ftp /root/.netrc
#nano /root/.netrc
#machine sitename1 login ftpuser1 password ftppassword1

#-----------------POCTFIX-----------------------------------#
sudo apt update
sudo apt install postfix mailutils
systemctl restart php8.0-fpm
apt-get install php-mysql php-mbstring php-imap
wget https://sourceforge.net/projects/postfixadmin/files/latest/download -O postfixadmin.tar.gz
mkdir /var/www/postfixadmin
tar -C /var/www/postfixadmin -xvf postfixadmin.tar.gz --strip-components 1
mkdir /var/www/postfixadmin/templates_c
mysql
CREATE DATABASE postfix DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE USER 'postfix'@'localhost' IDENTIFIED BY "postfix123";
GRANT ALL ON postfix.* TO 'postfix'@'localhost';
quit
nano /var/www/postfixadmin/config.local.php

####------------------------###------------------------------######
############УСТАНОВКА почты№№№№№№№№№№№№№№№№№№№№№№
sudo nano /etc/hosts
3.13.131.152 mail.example.com mail
3.13.131.152 mail.example.net mail
sudo certbot certonly --standalone
sudo apt-get update && sudo apt-get upgrade
sudo dpkg-reconfigure postfix
sudo apt-get install postfix postfix-mysql dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql mysql-server
sudo systemctl enable postfix dovecot
sudo nano /etc/dovecot/dovecot.conf > !include conf.d/*.conf protocols = imap lmtp
sudo nano /etc/dovecot/conf.d/10-master.conf
netstat -l -p | grep lmtp
sudo nano /etc/postfix/main.cf
sudo postconf > /dev/null
sudo systemctl restart postfix
sudo nano /etc/dovecot/conf.d/20-lmtp.conf - # https://doc.dovecot.org/configuration_manual/howto/postfix_dovecot_lmtp/
#--------------настройка и установка-------------------------#
# https://www.linode.com/docs/guides/email-with-postfix-dovecot-and-mysql/
sudo nano /etc/mailadmin - файлы для данных суперпользователя Postfixadmin
sudo nano /etc/example.com - данные для почтового ящика в домене example.com
sudo nano /etc/example.net - данные для почтового ящика в домене example.net
sudo mysql
#----------------------creat database-------------------------#
CREATE DATABASE mailserver;
CREATE USER 'mailuser'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON mailserver.* TO 'mailuser'@'localhost';
FLUSH PRIVILEGES;
USE mailserver;

CREATE TABLE `virtual_domains` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_users` (
  `id` int(11) NOT NULL auto_increment,
  `domain_id` int(11) NOT NULL,
  `password` varchar(106) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_aliases` (
  `id` int(11) NOT NULL auto_increment,
  `domain_id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#-------------example.com----------------------#
INSERT INTO mailserver.virtual_domains (name) VALUES ('example.com');
SELECT * FROM mailserver.virtual_domains;
# sudo doveadm pw -s SHA512-CRYPT -p "password" -r 5000 - шифрование пароля
INSERT INTO mailserver.virtual_users (domain_id, password , email) VALUES ('1', 'password', 'user@example.com');
SELECT * FROM mailserver.virtual_users;
#-------------example.com-alias---------------------#
INSERT INTO mailserver.virtual_aliases (domain_id, source, destination) VALUES ('1', 'alias@example.com', 'user@example.com');
SELECT * FROM mailserver.virtual_aliases;
#-------------example.net----------------------#
INSERT INTO mailserver.virtual_domains (name) VALUES ('example.net');
SELECT * FROM mailserver.virtual_domains;
# sudo doveadm pw -s SHA512-CRYPT -p "password" -r 5000 - шифрование пароля
INSERT INTO mailserver.virtual_users (domain_id, password , email) VALUES ('2', 'password', 'user@example.net');
SELECT * FROM mailserver.virtual_users;
#-------------example.net-alias---------------------#
INSERT INTO mailserver.virtual_aliases (domain_id, source, destination) VALUES ('2', 'alias@example.net', 'user@example.net');

#--------------------------setting POSTFIX main.cnf----------------------#
sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.orig
sudo nano /etc/postfix/main.cf
sudo nano /etc/postfix/mysql-virtual-mailbox-domains.cf
sudo nano /etc/postfix/mysql-virtual-mailbox-maps.cf
sudo nano /etc/postfix/mysql-virtual-alias-maps.cf
sudo nano /etc/postfix/mysql-virtual-email2email.cf
sudo cp /etc/postfix/master.cf /etc/postfix/master.cf.orig
sudo nano /etc/postfix/master.cf
sudo chmod -R o-rwx /etc/postfix
sudo systemctl restart postfix
#-------------------Configuring Dovecot----------------------#
sudo cp /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf.orig
sudo cp /etc/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf.orig
sudo cp /etc/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf.orig
sudo cp /etc/dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext.orig
sudo cp /etc/dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf.orig
sudo cp /etc/dovecot/conf.d/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf.orig
sudo nano /etc/dovecot/dovecot.conf > protocols = imap pop3 lmtp postmaster_address = postmaster at example.com postmaster_address = postmaster at example.net
sudo nano /etc/dovecot/conf.d/10-mail.conf > mail_location = maildir:/var/mail/vhosts/%d/%n/ > mail_privileged_group = mail
sudo mkdir -p /var/mail/vhosts/example.com
sudo mkdir -p /var/mail/vhosts/example.net
sudo groupadd -g 5000 vmail
sudo useradd -g vmail -u 5000 vmail -d /var/mail
sudo chown -R vmail:vmail /var/mail
sudo nano /etc/dovecot/conf.d/10-auth.conf > disable_plaintext_auth = yes > auth_mechanisms = plain login > !include auth-system.conf.ext > !include auth-sql.conf.ext
sudo nano /etc/dovecot/conf.d/auth-sql.conf.ext - # https://www.linode.com/docs/guides/email-with-postfix-dovecot-and-mysql/
sudo nano /etc/dovecot/dovecot-sql.conf.ext > # https://www.linode.com/docs/guides/email-with-postfix-dovecot-and-mysql/
