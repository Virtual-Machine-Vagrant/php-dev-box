# laravel-dev-box
A Vagrant powered virtual machine for Laravel application development

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/skanukov/laravel-dev-box
    host $ cd laravel-dev-box
    host $ vagrant up

That's it.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh

Port 8000 in the host computer is forwarded to port 8000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:8000 in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1, so it can access all interfaces:

    $ php artisan serve --host=0.0.0.0

Don't forget to look at some helper shell scripts for newbies.

## What's In The Box

* Ubuntu 16.04

* MySQL 5.7 with 'root:vagrant' superuser

* PHP7 7.1 with latest stable Composer

* NodeJS v6.9 LTS with Npm v3.10

* Lates stable Yarn

* Latest stable Git

## License

Released under the MIT License, Copyright (c) 2016 Sergey Kanukov, inspired by official [Rails dev box](https://github.com/rails/rails-dev-box).
