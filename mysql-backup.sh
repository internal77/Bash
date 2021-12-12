#!/bin/bash
#tar -czvf /backup/mysql/$(date +%d-%m-%Y).tar.gz /var/lib/mysql/wordpress_db /var/lib/mysql/drupal_db
#find /backup/mysql/* -mtime +30 -exec rm {} \;
#mysqldump -u root --opt -R sitemanager > /backup/sitemanager-$(date +%d%m%Y).sql
#find /backup/sitemanager0* -mtime +30 -exec rm {} \;
#exit 0

# mysqldump -u root -p6oWN.bzOIOIw!? wordpress_db > wordpress_backup.sql
# find /backup/wordpress* -mtime +30 -exec rm {} \;
# tar -czvf /backup/mysql/$(date +%d-%m-%Y)/wordpress.tar.gz /home/centos/wordpress_backup.sql
# find /backup/mysql/* -mtime +30 -exec rm {} \;
# exit 0
#!/bin/bash

# DUMP SQL BASE

mysqldump -u root -p6oWN.bzOIOIw!? wordpress_db > /home/centos/temp/wp.sql
echo DUMP wp.sql COMPLITED!!!!
sleep 1
mysqldump -u root -p6oWN.bzOIOIw!? drupal_db > /home/centos/temp/dp.sql
echo DUMP dp.sql COMPLITED!!!!
sleep 1

# COMPRESSION

echo Wait pls! Compression All Files...
sleep 1
mkdir -p /backup/mysql/`date +%d-%m-%Y`
tar -czvf /backup/mysql/`date +%d-%m-%Y`/wp.tar.gz  /home/centos/temp/wp.sql
echo COMPRESSION WORDPRESS COMPLITED!!!!
tar -czvf /backup/mysql/`date +%d-%m-%Y`/dp.tar.gz /home/centos/temp/dp.sql
echo COMPRESSION DRUPAL COMPLITED!!!!
echo COMPRESSION COMPLITED!!!!
sleep 1

# DELETE TEMP FILE

echo Wait PLS! CLEAR TEMP FILES!!!!
rm /home/centos/temp/*
echo TEMP files delete comlete!!!!
find /backup/mysql/* -mtime +30 -exec rm -rf {} \;
exit 0

# find /backup/mysql/ -maxdepth 1 -type -d -mtime +30 -exec rm -rf {} \;

# crontab -e - создание задания
# crontab -l > /path/to/file
# crontab -u user -l > /path/to/file
# crontab -l
