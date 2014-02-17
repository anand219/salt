#!/bin/bash

set -x
set -e

sudo apt-get update  # without this it fails
sudo apt-get install -y git # to be able to clone salt sources

git clone https://github.com/saltstack/salt.git
cd salt
git fetch --tags

# install dependencies
sudo apt-get install -y build-essential libssl-dev python-dev python-m2crypto \
  python-pip python-virtualenv swig virtualenvwrapper

# install dependencies for generating docs
sudo apt-get install -y python-sphinx

# create virtualenv
virtualenv --python=/usr/bin/python2.7 --system-site-packages .
source bin/activate

# install other dependencies
#pip install -r requirements.txt
pip install -r dev_requirements_python27.txt
pip install psutil
pip install -e .


mkdir -p etc/salt
cp conf/master etc/salt/master
cp conf/minion etc/salt/minion

sed -ri "s/^#user: .*$/user: `whoami`/" etc/salt/{master,minion}
sed -ri "s|^#root_dir: .*$|root_dir: $PWD|" etc/salt/{master,minion}
sed -ri "s/^#master: .*$/master: localhost/" etc/salt/minion

