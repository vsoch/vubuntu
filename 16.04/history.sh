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
sudo usermod -aG docker $USER

# Docker-compose
sudo apt -y install docker-compose

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

# Anaconda for Python
cd /home/vanessa/Downloads
wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
bash Anaconda3-4.2.0-Linux-x86_64.sh -b
echo "PATH=\$HOME/anaconda3/bin:\$PATH" >> $HOME/.profile
echo export PATH >> $HOME/.profile
rm Anaconda2-4.2.0-Linux-x86_64.sh
wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh
bash Anaconda2-4.2.0-Linux-x86_64.sh -b
rm Anaconda2-4.2.0-Linux-x86_64.sh


# Setup Kerberos for Sherlock
sudo apt-get -y install krb5-user openssh-client # ** interactive **
sudo curl -o /etc/krb5.conf https://web.stanford.edu/dept/its/support/kerberos/dist/krb5.conf

# Gimp and inkscape
sudo apt-get -y install gimp
sudo apt-add-repository ppa:otto-kesselgulasch/gimp
sudo apt-get update
sudo apt-get -y install inkscape
sudo apt-get -y install inkscape

# Ruby
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev

cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
rbenv install 2.3.1
rbenv global 2.3.1
gem install bundler
rbenv rehash
ruby -v

# Rails
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
gem install rails -v 4.2.6
rbenv rehash

# MySQL
sudo apt-get -y install mysql-server mysql-client libmysqlclient-dev

# Postgres
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-common
sudo apt-get -y install postgresql-9.5 libpq-dev

# If you would like to set a password for the user, you can do the following
sudo -u postgres createuser vanessa -s
sudo -u postgres psql
#postgres=# \password vanessa

# Jekyll
gem install jekyll
gem install github-pages
gem install jekyll-sass-converter

rbenv rehash

# Install Singularity
sudo apt-get install -y build-essential libtool autotools-dev automake autoconf
cd /tmp
git clone https://github.com/singularityware/singularity.git
cd singularity
./autogen.sh
./configure --prefix=/usr/local --sysconfdir=/etc
make
sudo make install

# Python packages (when anaconda3 is active)
pip install simplejson
gem install travis

# Install filezilla
sudo apt-get -y install filezilla
sudo apt-get -y install gftp

# Install curl (updated)
wget https://curl.haxx.se/download/curl-7.51.0.tar.gz
tar -xzvf curl-7.51.0.tar.gz 
cd curl-7.51.0 
./configure --with-nghttp2 --enable-ldap --with-libmetalink
make
sudo make install

# Java
sudo apt-get install default-jdk

# Install R Base and RStudio
sudo apt-get -y install gfortran
sudo apt-get -y install xorg-dev
sudo apt-get -y install liblzma-dev  libblas-dev gfortran
sudo apt-get -y install gcc-multilib
sudo apt-get -y install gobjc++
sudo apt-get -y install aptitude
sudo apt-get -y install libreadline-dev
sudo apt-get -y install libbz2-dev
sudo apt-get -y install liblzma-dev
sudo apt-get -y install libpcre3 libpcre3-dev
sudo apt-get -y install libcurl4-openssl-dev
cd /home/vanessa/Packages
wget https://cran.cnr.berkeley.edu/bin/linux/ubuntu/yakkety/r-base_3.3.2.orig.tar.gz
tar -xzvf r-base_3.3.2.orig.tar.gz
cd R-3.3.2
./configure --enable-R-shlib=yes
make
sudo make install

# Rstudio
sudo apt-get install libgstreamer0.10-0
sudo apt-get install libgstreamer-plugins-base0.10-dev
wget https://download1.rstudio.org/rstudio-1.0.44-x86_64-fedora.tar.gz
tar -xzvf rstudio-1.0.44-x86_64-fedora.tar.gz
echo "export PATH=$PATH:/home/vanessa/Packages/rstudio-1.0.44/bin" >> ~/.profile
source ~/.profile

# Google Cloud
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk # **interactive**
gcloud init

# Singularity Dependencies
sudo apt-get install -y automake autoconf libtool build-essential

# Helm
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz
tar -xzvf helm-v2.9.1-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/

# Vue.js
npm install -g @vue/cli
