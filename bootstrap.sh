#!/usr/bin/env bash
# Bootstrap file for setting Laravel development environment

# Heper functions
function append_to_file {
  echo $1 | tee -a $2
}

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

function add_php_ppa {
  install 'PHP PPA pre-requirements' python-software-properties
  sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
  update_packages
}

function install_php {
  add_php_ppa
  install 'PHP7 and Laravel dependencies' php7.0 \
    php7.0-mbstring php7.0-mysql php7.0-xml php7.0-zip
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

function add_git_ppa {
  sudo add-apt-repository ppa:git-core/ppa
  update_packages
}

function install_git {
  add_git_ppa
  install 'Git' git
}

function install_node {
  curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
  install 'NodeJS with Npm' nodejs
}

function set_node_permissions {
  echo 'Setting correct NodeJS permissions...'
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  append_to_file '' ~/.profile # insert empty line first
  append_to_file 'export PATH=~/.npm-global/bin:$PATH' ~/.profile
  source ~/.profile
}

function install_node_and_set_permissions {
  install_node
  set_node_permissions
}

update_packages
install_mysql
install_php_with_composer
install_git
install_node_and_set_permissions

echo 'All set, rock on!'
