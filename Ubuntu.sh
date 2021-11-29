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
apt-install ftp
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
