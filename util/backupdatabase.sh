#!/bin/sh

USER=user
PASS=pass
HOST=host.com
PREFIX=TEST_
timenow=${date -d today +"%Y%m%d"}

MYSQL=$(mysql -N -u${USER} -p${PASS} -h${HOST} <<<"SHOW DATABASES" | grep -v tmp | grep -v innodb | grep -v performance_schema | grep -v mysql | grep -v information_schema | grep -v test | tr "\n" " ")


#backup database structure
mysqldump -v -u${USER} -p${PASS} -h${HOST} --default-character-set=utf8 --skip-lock-tables  --databases ${MYSQL} --add-drop-database --no-data > ${PREFIX}mysql_backup_nodata_${timenow}.sql

#backup specified database
sdb=test
mysqldump -v -u${USER} -p${PASS} -h${HOST} --default-character-set=utf8 --skip-lock-tables  --databases ${sdb} --add-drop-database  > ${PREFIX}mysql_backup_${sdb}_${timenow}.sql

#backup all the database
mysqldump -v -u${USER} -p${PASS} -h${HOST} --default-character-set=utf8 --skip-lock-tables  --databases ${MYSQL} --add-drop-database  > ${PREFIX}mysql_backup_all_${timenow}.sql

#zip the files
zip ${PREFIX}mysql_backup_${timenow}.zip ./*.sql

#then you can use scp to copy the zip file like:
#  scp -i [pem] [user]@[host]:[full path] .