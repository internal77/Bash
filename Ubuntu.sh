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
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.34.0.tar.gz
tar xzf git-2.34.0.tar.gz
cd git-2.34.0
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
# symlink ln -s /data/mysql /var/lib/mysql    ln -s /data/www /var/www
# created swap file - sudo fallocate -l 1G /swap - sudo mkswap /swap - sudo swapon /swap - sudo nano /etc/fstab > /swap none swap defaults 0 0
# -----------------Установка NGINX----------------------
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
# systemctl start nginx
# systemctl enable nginx
# systemctl status nginx
# /etc/nginx/conf.d/

#-----------------Установка MYSQL-------------------------#
# cd /tmp
# wget https://dev.mysql.com/get/mysql-apt-config_0.8.20-1_all.deb
# sudo dpkg -i mysql-apt-config_0.8.20-1_all.deb
sudo apt update
sudo apt-get install mysql-server
sudo mysql_secure_installation
# systemctl start mysql
# systemctl enable mysql
# systemctl status mysql

#---------------Установка--APACHE-----------------------------------#
sudo apt update
sudo apt install apache2
# systemctl start apache2
# systemctl enable apache2
# systemctl status apache2

#---------------Установка--PHP8-----------------------------------#
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.0 libapache2-mod-php8.0
sudo apt install php8.0-cli php8.0-common php8.0-fpm php8.0-redis php8.0-snmp php8.0-xml
