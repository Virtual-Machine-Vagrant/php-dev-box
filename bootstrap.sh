#!/usr/bin/env bash
# Bootstrap file for setting PHP development environment

# Heper functions
function append_to_file {
  echo "$1" | sudo tee -a "$2"
}

function replace_in_file {
  sudo sed -i "$1" "$2"
}

function install {
  echo "Installing $1..."
  shift
  sudo apt-get -y install "$@"
}

function update_packages {
  echo 'Updating package information...'
  sudo apt-get -y update
}

function add_repository {
  sudo add-apt-repository "$1"
  update_packages
}
# End of Heper functions

# Dependencies
function install_git {
  add_repository ppa:git-core/ppa
  install 'Git' git
}

function install_dependencies {
  sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

  install_git
}
# Enf of Dependencies

# MySQL
function set_mysql_root_password {
  sudo debconf-set-selections <<< \
    "mysql-server mysql-server/root_password password $1"
  sudo debconf-set-selections <<< \
    "mysql-server mysql-server/root_password_again password $1"
}

function install_mysql {
  set_mysql_root_password 'vagrant'
  install 'MySQL' mysql-server
}
# End of MySQL

# PHP 7.1
function install_php {
  add_repository ppa:ondrej/php

  install 'PHP7 and dependencies' php7.1 \
    php7.1-mbstring php7.1-mysql php7.1-xml php7.1-zip # Laravel deps
}

function install_composer {
  echo 'Installing Composer...'
  curl -sS https://getcomposer.org/installer | \
    sudo php -- --install-dir=/usr/local/bin --filename=composer
}

function install_php_and_composer {
  install_php
  install_composer
}
# End of PHP 7.1

# NodeJS and Yarn
function install_node {
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
  update_packages
  install 'NodeJS' nodejs
}

function add_yarn_to_path {
  append_to_file 'export PATH="$PATH:`yarn global bin`"' ~/.profile
  source ~/.profile
}

function install_yarn {
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  append_to_file "deb https://dl.yarnpkg.com/debian/ stable main" \
    /etc/apt/sources.list.d/yarn.list
  update_packages
  install 'Yarn' yarn

  add_yarn_to_path
}

function install_node_and_yarn {
  install_node
  install_yarn
}
# End of NodeJS and Yarn


update_packages
install_dependencies
install_mysql
install_php_and_composer
install_node_and_npm


echo 'All set, rock on!'
