FROM wordpress:5.0.3-php7.2-fpm

COPY docker-entrypoint.sh /usr/local/bin/

# install wpcli 
COPY wpcli /usr/local/bin

# Copy our PHP options into the image
COPY php.ini /usr/local/etc/php/conf.d/

#create new documentRoot for wordpress
RUN mkdir /var/www/wordpress

# Make www-data owner of the WordPress folders (as we won't run the container as root)
RUN chown -R www-data:www-data /var/www/wordpress 

#change home of www-data
RUN usermod -d /var/www/wordpress www-data \
    && chmod 0775 /var/www/wordpress

USER www-data

WORKDIR /var/www/wordpress

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]