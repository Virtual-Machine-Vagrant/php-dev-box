#!/usr/bin/env bash
# Bootstrap file for setting Laravel development environment

# Heper functions
function install {
  echo Installing $1...
  shift
  sudo apt-get -y install "$@"
}

function update_packages {
  echo 'Updating package information...'
  sudo apt-get -y update
}
# End of Heper functions

function set_default_mysql_root_password {
  sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $1"
  sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $1"
}

function install_mysql {
  set_default_mysql_root_password 'vagrant'
  install 'MySQL' mysql-server
}

function install_php {
  install 'PHP7 and Laravel dependencies' php \
    php-mysql php-mbstring php-xml php-zip
}

function install_composer {
  echo 'Installing Composer...'
  curl -sS https://getcomposer.org/installer | \
    sudo php -- --install-dir=/usr/local/bin --filename=composer
}

function install_php_with_composer {
  install_php
  install_composer
}

update_packages
install_mysql
install_php_with_composer
