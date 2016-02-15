#!/bin/bash
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-precise.deb
sudo dpkg -i puppetlabs-release-pc1-precise.deb
## wybrac odpowiednia wersje
##https://apt.puppetlabs.com/
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-wheezy.deb | dpkg
dpkg -i puppetlabs-release-pc1-wheezy.deb

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo debian-wheezy main"> /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install puppet apt-transport-https ca-certificates

puppet module install garethr/docker
puppet apply ./redis.pp
