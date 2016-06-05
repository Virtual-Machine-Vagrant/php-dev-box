# laravel-dev-box
A Vagrant powered virtual machine for Laravel application development

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## Recommended software

* [Vagrant-vbguest plugin](https://github.com/dotless-de/vagrant-vbguest)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    $ git clone https://github.com/skanukov/laravel-dev-box
    $ cd laravel-dev-box
    $ vagrant up

That's it.

After the installation has finished, you can access the virtual machine with

    $ vagrant ssh

Port 8000 in the host computer is forwarded to port 8000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:8000 in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1, so it can access all interfaces:

    php artisan serve --host=0.0.0.0

Don't forget to look at some helper shell scripts for newbies.

## Install recommended software

Install vagrant-vbguest plugin:

    $ vagrant plugin install vagrant-vbguest

## What's In The Box

* Current stable PHP7 with Composer

* Current stable MySQL with 'root:vagrant' superuser

* Current stable Git

* Current stable NodeJS v4 LTS with Npm

## License

Released under the MIT License, Copyright (c) 2016 Sergey Kanukov, inspired by official [Rails dev box](https://github.com/rails/rails-dev-box).
