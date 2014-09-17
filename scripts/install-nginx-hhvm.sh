#!/bin/sh
# expects install-basics.sh to be executed before

export DEBIAN_FRONTEND=noninteractive

# nginx
add-apt-repository -y ppa:nginx/development
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

  # Make site accessible from http://localhost/
  server_name localhost;
  include hhvm.conf;

  location / {
    index index.php;
    try_files \$uri =404;
    error_page 404 = @kisakone;
  }

  location @kisakone {
    rewrite ^/(.*)\$ /index.php?path=\$1&\$query_string last;
  }

  location ~ /\.ht {
    deny all;
  }
}
EOF
(cd /etc/nginx/sites-enabled; rm -f default; ln -s ../sites-available/kisakone)

# configure and restart stuff
service nginx restart
service hhvm restart
