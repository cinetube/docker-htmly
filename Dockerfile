FROM alpine:latest
MAINTAINER John Miller <john@harleydigital.com>

# Get the packages
RUN apk add --no-cache \
        bash nginx ca-certificates \
        php7-fpm php7-json php7-zlib php7-xml php7-gd php7-pdo \
        php7-phar php7-openssl php7-zip php7-iconv php7-mcrypt musl \
        && rm -rf /var/cache/apk/*

# add the necessary files
ADD nginx.conf /etc/nginx
ADD php-fpm.conf /etc/php5
ADD run.sh /
ADD index.php /

# get the HTMLy installer
ADD https://github.com/danpros/htmly/releases/download/v2.7.4/installer.php /

# make the run script executable
RUN chmod +x /run.sh

# open the port
EXPOSE 80

# set the data volume
VOLUME ["/data/"]

# start
CMD ["/run.sh"]
