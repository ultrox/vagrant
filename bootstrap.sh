#!/bin/sh
apt-get update \
  && apt-get install -y locales \
  && locale-gen en_US.UTF-8

export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

apt-get update \
  && apt-get install -y nginx curl zip unzip git software-properties-common \
  && add-apt-repository -y ppa:ondrej/php \
  && apt-get update \
  && apt-get install -y php7.0-fpm php7.0-cli php7.0-mcrypt php7.0-gd php7.0-mysql \
  php7.0-imap php-memcached php7.0-mbstring php7.0-xml php7.0-curl php7.0-xdebug \
  && apt-get remove -y --purge software-properties-common \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log


# setup env vars

cp -rf /vagrant/.provision/default /etc/nginx/sites-available/default
cp -rf /vagrant/.provision/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
# cp -rf /vagrant/.provision/php.ini /etc/php7/conf.d/zzz_custom.ini

# dmc must be here
# cp src/ /var/www/html/public
# chown -R www-data: /var/www/html
sudo systemctl reload nginx
## Vagrant specific
cp -r /vagrant/.provision/vim ~/.vim
cp /vagrant/.provision/vim/vimrc ~/.vimrc

cat > ~/.vim/filetype.vim <<EOF
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
EOF

