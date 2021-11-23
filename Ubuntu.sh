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
