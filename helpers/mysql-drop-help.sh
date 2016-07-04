#!/usr/bin/env bash
# Print commands to drop MySQL db and user

echo 'Drop MySQL database:'
echo 'mysql> DROP DATABASE IF EXISTS db_name;'
echo ''

echo 'Drop MySQL user:'
echo "mysql> DROP USER IF EXISTS 'user_name'@'localhost';"
echo ''

echo 'Exit mysql:'
echo 'mysql> EXIT;'
echo ''

mysql -u root -p
