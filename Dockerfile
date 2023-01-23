FROM alpine:3.17 as source

RUN apk update
RUN apk add git
RUN git clone -b master https://github.com/Karakean/Electronic-Business.git


FROM prestashop/prestashop:8.0.0

RUN rm -rf *
COPY --from=source /Electronic-Business/prestashop .

RUN apt update -y
RUN apt install -y memcached
RUN apt install -y libz-dev libmemcached-dev
RUN pecl install memcached
RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini

COPY --from=source /Electronic-Business/ssl /etc/ssl/dlugierozdzki
COPY --from=source /Electronic-Business/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
RUN a2enmod ssl

RUN chmod -R 775 .
RUN chown -R www-data:www-data .
RUN rm -rf var/cache/prod/*

EXPOSE 80
EXPOSE 443
