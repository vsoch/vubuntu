#!/bin/sh
# History of Commands, Vubuntu

# Manual changes to gedit on opening:
# - add line numbers
# - cobalt color theme under preferences
# - show margin at 80 characters from left

# Install Dropbox Desktop App (using app store), starting Dropbox,
# changing dropbox location to /home/vanessa/Documents (creates Dropbox under that)

# This is how bios were updated, downloaded from Lenovo site

cd Downloads/
ls -Ag
fwupdmgr n2jul22w.zip
fwupdmgr install n2jul22w.zip
cd n2jul22w/
ls
# fwupdmgr install N2JET84w.cab
# fwupdmgr install N2JET84W.cab
# fwupdmgr install N2JHT33W.cab
sudo reboot

# Install git and temperature sensors (sensors)
sudo apt-get update
sudo apt-get install -y git lm-sensors vim
# sensors

# Check bios version
sudo dmidecode -s bios-version
# N2JET84W (1.62 )

# Generate ssh and gpg keys for it
ssh-keygen -t rsa -b 4096 -C "vsochat@stanford.edu"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
vim /home/vanessa/.ssh/id_rsa.pub 
# gpg: https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key
git config --global commit.gpgsign true
git config --global user.email "vsochat@stanford.edu"
git config --global user.name "vsoch"

# Anaconda for Python
cd /tmp
wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
bash Anaconda3-2019.10-Linux-x86_64.sh -p /home/vanessa/anaconda3 -b
echo "PATH=\$HOME/anaconda3/bin:\$PATH" >> $HOME/.profile
echo export PATH >> $HOME/.profile

# Docker
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install docker-ce
sudo usermod -aG docker $USER
# will need restart to add user to docker group

# Install GoLang
# get tar.gz from https://golang.org/dl/
wget https://dl.google.com/go/go1.13.7.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.13.7.linux-amd64.tar.gz 
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=\$PATH:/usr/local/go/bin" >> $HOME/.profile

# Install Singularity
sudo apt-get install -y gcc build-essential

# Make temporary GOPATH just to install singularity
mkdir -p $HOME/Desktop/Code/go/src/github.com/sylabs
export GOPATH=$HOME/Desktop/Code/go
cd $HOME/Desktop/Code/go/src/github.com/sylabs
git clone git@github.com:sylabs/singularity.git
cd singularity
./mconfig
cd builddir
make
sudo make install

# Google Cloud
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
gcloud init
