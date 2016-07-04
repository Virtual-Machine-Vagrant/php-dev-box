#!/usr/bin/env bash
# Create new Laravel app

if [ "$#" -ne 1 ]; then
  echo 'Illegal number of parameters: pass app_name'
  exit 1
fi

echo "Creating new Laravel app..."
composer create-project --prefer-dist laravel/laravel "$1"
