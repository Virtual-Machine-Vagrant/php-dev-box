#!/usr/bin/env bash
# Run mysql

# Use database to connect to if provided
db_arg=''
if [ -n "$1" ]; then
  db_arg="-D $1"
fi

echo 'Running mysql...'
mysql -u root -p "$db_arg"
