#!/bin/bash

sudo apt-get install bluez bluez-test-scripts python3-bluez python3-dbus libsqlite3-dev ubertooth


sudo apt-get install ruby-dev bundler


cp scan.sh bluehydra.sh blue_hydra/

# change directory
cd blue_hydra

# install dependencies

bundle install

