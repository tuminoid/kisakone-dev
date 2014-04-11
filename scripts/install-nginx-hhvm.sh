#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# update repos
apt-get -y update

# basics
apt-get -y install git nano curl wget nmap command-not-found man python-software-properties

# nginx
add-apt-repository -y ppa:nginx/stable
apt-get -y update
apt-get -y install nginx

# hhvm
add-apt-repository -y ppa:mapnik/boost
wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
echo deb http://dl.hhvm.com/ubuntu precise main | tee /etc/apt/sources.list.d/hhvm.list
apt-get -y update
apt-get -y install hhvm
update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60
/usr/share/hhvm/install_fastcgi.sh

# setup kisakone
cat <<EOF >/etc/nginx/sites-available/kisakone
server {
  listen 80 default_server;

  root /kisakone;
  index index.php;

  # Make site accessible from http://localhost/
  server_name localhost;
  include hhvm.conf;

  location / {
    # First attempt to serve request as file, then
    # as directory, then fall back to displaying a 404.
    try_files \$uri \$uri/ =404;
  }

  # deny access to .htaccess files, if Apache's document root
  # concurs with nginx's one
  #
  location ~ /\.ht {
    deny all;
  }
}
EOF
(cd /etc/nginx/sites-enabled; rm -f default; ln -s ../sites-available/kisakone)

# configure and restart stuff
service nginx restart
service hhvm restart
