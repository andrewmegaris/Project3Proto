#! bin/bash

#This script is supposed to be run before the repo is downloaded
#it will take care of setting up ruby, the cloud drive app, and starting the service.

#This script will set up the cloud drive application on a linux distribution (Rasbian in our case).
#It can take a few hours to compile ruby 2.3.0 and install all dependencies on the Raspberry pi.

#update the Raspberry pi
sudo apt-get update
sudo apt-get upgrade

#Install rails dependencies and Ruby Version Manager(rvm). 
#This will compile ruby 2.3.0 on the Raspberry pi.
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libpq-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --rails

#clone the git repository
git clone https://github.com/andrewmegaris/project3proto.git

#move to the project directory
cd project3proto

#update Rubygems to the newest version
sudo gem update --system

#install the bundler gem
sudo gem install bundler

#install the cloud drive ruby gem dependencies specified in the Gemfile and Gemfile.lock
bundle install

#set up the database with the initial database migration
cd bin
rake db:migrate RAILS_ENV=development
cd ..

#launch the cloud server application on port 80
rvmsudo rails server --binding=0.0.0.0 --port=80