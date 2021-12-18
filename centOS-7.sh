#!/bin/bash
# Redis
# SElinux - disable - sudo nano /etc/selinux/config 'SELINUX=disabled'
# sudo shutdown -r now
# sestatus
sudo yum -y update
sudo yum -y install  nano
sudo yum -y install yum-utils
sudo yum -y install epel-release
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E '%{rhel}').noarch.rpm
sudo yum repolist
#sudo yum -y install php
#sudo yum-config-manager --enable remi-php72
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi
sudo yum --enablerepo=remi --show-duplicates list all redis
sudo yum --enablerepo=remi install redis-6.0.16-1.el7.remi
# Logs
sudo mkdir -p /root/tasks/1/
rpm -ql  redis > /root/tasks/1/packagefileslist
cat /root/tasks/1/packagefileslist
rpm -qf /etc/locale.conf > /root/tasks/1/filetopackagename
cat /root/tasks/1/filetopackagename
# Git
sudo yum  update
sudo yum -y install make
sudo yum -y install -y build-essential libssl-dev libcurl4-gnutls-dev perl-devel openssl-devel curl-devel expat-devel gettext-devel openssl-devel libexpat1-dev gettext unzip wget gcc
cd /usr/local/src
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.34.1.tar.gz
tar xzf git-2.34.1.tar.gz
cd git-2.34.1
make prefix=/usr/local/git all
make prefix=/usr/local/git install
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc # export PATH="$PATH:/usr/local/sbin/bin"
source /etc/bashrc
git --version
# uninstall old version git - sudo yum remove git*
# Disk add
# df -h, lsblk
# fdisk -l, fdisk /dev/disk, mkfs.xfs /dev/disk
# mkdir /data, mount /dev/nvme1n1p1 /data
# sudo blkid
# sudo nano /etc/fstab swap add sudo nano /etc/fstab
# symlink ln -s /data/mysql /var/lib/mysql    ln -s /data/www /var/www
# created swap file - sudo fallocate -l 1G /swap(sudo dd if=/dev/zero of=/swap bs=1MiB count=1000) - sudo chmod 600 /swap - sudo mkswap /swap - sudo swapon /swap - sudo nano /etc/fstab > /swap none swap defaults 0 0
# swapon --show
# free- h
#-------------------------------------------------------------------------------------#
# ----------------install Apachecd /var/www--------------------
sudo yum update
sudo yum -y install httpd
sudo systemctl start httpd
systemctl enable httpd
sudo systemctl status httpd
# /etc/httpd/conf/httpd.conf - >> Listen 8080
# systemctl restart httpd
# ------------------install nginx---------------------------#
sudo nano /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
sudo yum -y install nginx
# yum -y install nginx
# systemctl start nginx
# systemctl enable nginx
# systemctl status nginx
# /etc/nginx/conf.d/

#------------------------------------------------------------------#
# php 8.0 repository remi
# yum search php80 php80-php
# yum info php80 php80-php
# delete old version php - yum -y remove php*
# https://computingforgeeks.com/how-to-install-php-8-on-centos-linux/
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum -y install yum-utils
sudo yum-config-manager --disable 'remi-php*'
sudo yum-config-manager --enable remi-safe
sudo yum  install php80
yum install php80-php-fpm
yum install  php80-php-common php80-php-pecl-mysql php80-php-pecl-zip php80-php-mysqlnd php80-php-gb php80-php-intl php80-php-imap php80-php-ldap php80-php-imap php80-php-mbstring php80-php-opcache php80-php-pdo php80-php-sodium php80-php-xml
#systemctl start php80-php-fpm
#systemctl enable php80-php-fpm
#systemctl status php80-php-fpm
# ---------------install latest mysql Oracle latest mysql (из официального Oracle репозитория MySQL)
wget https://dev.mysql.com/get/mysql80-community-release-el7-4.noarch.rpm
rpm -ivh mysql80-community-release-el7-4.noarch.rpm
yum install -y mysql-community-server
# yum install -y mysql-workbench-community
# systemctl enable mysqld
# systemctl start mysqld
# systemctl stop mysqld
# создать файл /root/.my.cnf > chmod 600
# sudo mysql_secure_installation
# sudo grep 'temporary password' /var/log/mysqld.log - временный пароль # <r-Y6rt4tgql
# mysql -u root -p
# ALTER USER 'root'@'localhost' IDENTIFIED BY '6oWN.bzOIOIw!?'; - изменение пароля - 6oWN.bzOIOIw!?
# CREATE DATABASE new_database;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';
# CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
# iptables -I INPUT -d 127.0.0.1/8 -j ACCEPT
# iptables -A INPUT -p tcp --dport 3306 -j DROP
# /etc/ my.cnf > bind-address=127.0.0.1
# FLUSH PRIVILEGES;
# /q
# passwords users:
# wordpress_user - 6oWN.bzOIOIw!1
# drupal_user - 6oWN.bzOIOIw!2
# show databases;

# Настроить nginx как обратный прокси-сервер
#nginx как обратный прокси-сервер.
/etc/nginx/sites-enabled/ ??
sudo ln -s /etc/nginx/sites-available/ /etc/nginx/sites-enabled/
# Установка DRUPAL
cd /
cd /tmp
wget https://www.drupal.org/download-latest/tar.gz -O drupal.tar.gz
tar xvf drupal.tar.gz
rm -f drupal*.tar.gz
cd /var/www/drupal.example.com/drupal-*
sudo mv drupal-*/  /var/www/drupal.example.com
cd ..
mkdir sites/default/files
cp ./sites/default/default.settings.php  ./sites/default/settings.php
chown -R apache:apache settings.php
chown -R :apache /var/www/drupal.example.com/sites/default/files

# Установка WORDPRESS
cd /
cd /tmp
wget http://wordpress.org/latest.zip
unzip -q latest.zip -d /var/www/wordpress.example.com
cd /var/www/wordpress.example.com/wordpress
mv  -v /var/www/wordpress.example.com/wordpress/* /var/www/wordpress.example.com/
# cp -a /var/www/wordpress.example.command
mv wp-config-sample.php wp-config.php
nano wp-config.php > # данные базы данных и пользователя
mkdir /var/www/wordpress.example.com/wp-content/uploads
sudo chown -R php-fpm:php-fpm /var/www/wordpress.example.com
sudo chown -R php-fpm:php-fpm /var/www/wordpress.example.com/wp-content/uploads
chmod -R 775 /var/www/wordpress.example.com/wp-content/uploads
chmod -R 775 /var/www/wordpress.example.com
nginx -T | grep wordpress.example.com
#
# cp -a /source/. /dest/
# Настройка php & nginxcp
# сохранить оригинал /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.original
adduser php-fpm
# nano /etc/php-fpm.d/www.conf >
nano /etc/opt/remi/php80/php-fpm.d/www.conf
# > listen = /var/run/php-fpm/php-fpm.sock
# > listen.mode = 0660
# > listen.owner = nginx
# > listen.group = nginx
ss -tapn
# nano /etc/nginx/conf.d/wordpress.example.com.conf > fastcgi_pass unix:/run/php-fpm.sock
# systemctl start php-fpm
systemctl start php80-php-fpm
systemctl enable php80-php-fpm
# systemctl restart php-fpm
# systemctl restart nginx
mkdir -p /var/lib/php/session
chown -R nginx:nginx /var/lib/php/session
chmod -R 755 /var/lib/php/session
# -------------------------------
# -----------------FTP НАСТРОЙКА----------------------------
yum install pure-ftpd-selinux
systemctl start pure-ftpd
# PassivePortRange 40000 50000
# iptables --append INPUT -m state --state NEW -m tcp -p tcp --dport 48000:50000 -j ACCEPT
#
sudo syatemctl enable pure-ftpd
cd /etc/pure-ftpd
sudo nano /etc/pure-ftpd/pure-ftpd.conf > PassivePortRange 45000 50000 > PureDB /etc/pure-ftpd/pureftpd.pdb
ftp -p -d 10.112.2.136
ftp -p -v -d 10.112.2.136
netstat -tnulp | grep pure-ftpd
sudo pure-pw list
# -----------------ПОЛЬЗОВАТЕЛЬ WORDPRESS---------------------------
# sudo groupadd ftpusers
sudo chown -R :php-fpm /var/www/wordpress.example.com/wp-content/uploads
sudo chmod -R g+w /var/www/wordpress.example.com/wp-content/uploads
# useradd wordpress
# sudo gpasswd -a wordpress ftpusers
sudo chown php-fpm:php-fpm /var/www/wordpress.example.com/wp-content/uploads -R
# sudo pure-pw useradd wordpress -u php-fpm -g php-fpm -d /var/www/wordpress.example.com/wp-content/uploads -m
sudo pure-pw useradd wordpress -u php-fpm -g php-fpm -d /var/www/wordpress.example.com -m
sudo pure-pw mkdb
sudo systemctl restart pure-ftpd
sudo pure-pw show wordpress
#-------------------FTPUSER-------------------------------------------#
sudo pure-pw useradd ftpuser -u php-fpm -g php-fpm -d /backup/duplicity -m - для бекапа
# sudo pure-pw useradd
sudo pure-pw mkdb
sudo user add ftpuser
sudo usermod -aG php-fpm ftpuser
sudo chown php-fpm:php-fpm /backup/duplicity
sudo chmod -R g+w /backup/duplicity
sudo chown ftpuser:php-fpm /backup/duplicity
sudo chmod -R g+w /backup/duplicity
sudo pure-pw mkdb
# https://code.launchpad.net/duplicity/0.8-series/0.8.20/+download/duplicity-0.8.20.tar.gz
# sudo pure-pw passwd - смена пароля
# sudo pure-ftpwho - простмотр активности
# pure-pw userdel -удаление пользователя

# ПОЛЬЗОВАТЕЛЬ DRUPAL---------------------------
# sudo groupadd ftpusers1
sudo chown -R :apache /var/www/drupal.example.com/sites/default/files
sudo chmod -R g+w /var/www/drupal.example.com/sites/default/files
# sudo gpasswd -a drupal ftpusers1
sudo chown apache:apache /var/www/drupal.example.com/sites/default/files -R
# sudo pure-pw useradd drupal -u apache -g apache -d /var/www/drupal.example.com/sites/default/files -m
sudo pure-pw useradd drupal -u apache -g apache -d /var/www/drupal.example.com -m
# pure-pw useradd drupal -u drupal -g ftpusers1 -d /var/www/drupal.example.com/sites/default/files -m
sudo pure-pw mkdb
sudo systemctl restart pure-ftpd
sudo pure-pw show drupal
more /var/log/messages | grep pure-ftpd   -  посмотреть ЛОГИ!!!!!
# Settings ftp /root/.netrc
nano /root/.netrc
#machine sitename1 login ftpuser1 password ftppassword1
#-------------DUPLICITY------------------------------#
wget https://files.pythonhosted.org/packages/23/01/c8fabb7811feb13d762d976155f3dba912f0dab93f033c655f3180148574/duplicity-0.8.21.post7.tar.gz
tar xzf duplicity-0.8.21.post7.tar.gz
cd duplicity-0.8.21.post7
python3 setup.py install
wget https://files.pythonhosted.org/packages/28/e4/2888d41cdbd405828ccdb9a8536c5919939c2f4c6ab9b2ba63e9bd2570d5/fasteners-0.16.3.tar.gz
tar xzf fasteners-0.16.3.tar.gz
cd fasteners-0.16.3
python3 setup.py install
wget https://files.pythonhosted.org/packages/45/0b/38b06fd9b92dc2b68d58b75f900e97884c45bedd2ff83203d933cf5851c9/future-0.18.2.tar.gz
tar xzf future-0.18.2.tar.gz
cd future-0.18.2
python3 setup.py install
