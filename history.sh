#!/bin/sh
# History of Commands, Vubuntu

# Install Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# Install Dropbox Desktop App
cd /home/vanessa/Downloads
mkdir dropbox
cd dropbox
wget https://www.dropbox.com/download?dl=packages/debian/dropbox_2015.10.28_amd64.deb
sudo dpkg -i dropbox_2015.10.28_amd64.deb 
sudo apt-get install -f .
cd ..
rm -rf dropbox

# Now the Dropbox Daemon
dropbox start -i
echo fs.inotify.max_user_watches=100000 | sudo tee -a /etc/sysctl.conf; sudo sysctl -p

# Docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee --append /etc/apt/sources.list.d/docker.list
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get -y install docker-engine
sudo service docker start
sudo docker run hello-world

# Vim
sudo apt-get -y install vim

# Git
sudo apt-get -y install git
ssh-keygen -t rsa -b 4096 -C "vsochat@stanford.edu"  # ** interactive **
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
# Add key to github ssh keys under Settings
git config --global user.email "vsochat@stanford.edu"
git config --global user.name "vsoch"
