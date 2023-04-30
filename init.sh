#!/bin/bash

sudo apt-get install bluez bluez-test-scripts python3-bluez python3-dbus libsqlite3-dev ubertooth


sudo apt-get install ruby-dev bundler


# clone the repository
git clone https://github.com/pwnieexpress/blue_hydra.git

# change directory
cd blue_hydra

# install dependencies

bundle install

