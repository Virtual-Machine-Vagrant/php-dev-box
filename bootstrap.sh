#!/usr/bin/env bash
# Bootstrap file for setting Laravel development environment

# Heper functions
function append_to_file {
  echo $1 >> $2
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
# End of Heper functions

function install_dependencies {
  sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
  install 'Git' git
}

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

function install_php {
  install 'PHP7 and Laravel dependencies' php7.0 \
    php7.0-mbstring php7.0-mysql php7.0-xml php7.0-zip
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

function create_node_symlink {
  sudo ln -s /usr/bin/nodejs /usr/bin/node
}

function install_node {
  install 'NodeJS' nodejs
  create_node_symlink
}

function set_npm_permissions {
  echo 'Setting correct Npm permissions...'
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  append_to_file 'export PATH=~/.npm-global/bin:$PATH' ~/.profile
  source ~/.profile
}

function install_npm {
  install 'Npm' npm
  set_npm_permissions
}

function install_node_and_npm {
  install_node
  install_npm
}

function install_gulp {
  echo 'Installing Gulp...'
  npm install gulp --global
}

update_packages
install_dependencies
install_mysql
install_php_and_composer
install_node_and_npm
install_gulp

echo 'All set, rock on!'
