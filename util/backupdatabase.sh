#!/usr/sh

USER=user
PASS=pass
HOST=host.com
PREFIX=TEST_

MYSQL=$(mysql -N -u${USER} -p${PASS} -h${HOST} <<<"SHOW DATABASES" | grep -v tmp | grep -v innodb | grep -v performance_schema | grep -v mysql | grep -v information_schema | grep -v test | tr "\n" " ")


#backup database structure
mysqldump -v -u${USER} -p${PASS} -h${HOST} --default-character-set=utf8 --skip-lock-tables  --databases ${MYSQL} --add-drop-database --no-data > ${PREFIX}mysql_backup_nodata.sql

#backup specified database
sdb=test
mysqldump -v -u${USER} -p${PASS} -h${HOST} --default-character-set=utf8 --skip-lock-tables  --databases ${sdb} --add-drop-database  > ${PREFIX}mysql_backup_${sdb}.sql

#backup all the database
mysqldump -v -u${USER} -p${PASS} -h${HOST} --default-character-set=utf8 --skip-lock-tables  --databases ${MYSQL} --add-drop-database  > ${PREFIX}mysql_backup_all.sql


