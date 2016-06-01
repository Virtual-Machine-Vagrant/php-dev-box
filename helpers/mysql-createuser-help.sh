#!/usr/bin/env bash
# A helper file to print the MySQL create user command

echo "MySQL create user command sample:"
echo "mysql -u user_name[root by default] -p"
echo "CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';"
echo "GRANT ALL ON db_name.* TO 'newuser'@'localhost';"
echo "FLUSH PRIVILEGES;"
