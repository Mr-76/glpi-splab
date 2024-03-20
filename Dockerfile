FROM debian
RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y apache2 php php-apcu php-cli php-common php-curl php-gd php-imap php-ldap php-mysql php-xmlrpc php-xml php-mbstring php-bcmath php-intl php-zip php-redis php-bz2 libapache2-mod-php php-soap php-cas wget tar

WORKDIR /var/www/html

RUN wget https://github.com/glpi-project/glpi/releases/download/10.0.12/glpi-10.0.12.tgz && \
    tar -xvzf glpi-10.0.12.tgz && \
    mv /var/www/html/glpi/config /etc/glpi && \
    mv /var/www/html/glpi/files /var/lib/glpi && \
    mv /var/lib/glpi/_log /var/log/glpi && \
    chown root:root /var/www/html/glpi/ -R && \
    chown www-data:www-data /etc/glpi -R && \
    chown www-data:www-data /var/lib/glpi -R && \
    chown www-data:www-data /var/log/glpi -R && \
    chown www-data:www-data /var/www/html/glpi/marketplace -Rf && \
    find /var/www/html/glpi/ -type f -exec chmod 0644 {} \;&& \ 
    find /var/www/html/glpi/ -type d -exec chmod 0755 {} \;&& \
    find /etc/glpi -type f -exec chmod 0644 {} \; && \ 
    find /etc/glpi -type d -exec chmod 0755 {} \; && \
    find /var/lib/glpi -type f -exec chmod 0644 {} \; && \ 
    find /var/lib/glpi -type d -exec chmod 0755 {} \; && \
    find /var/log/glpi -type f -exec chmod 0644 {} \; && \
    find /var/log/glpi -type d -exec chmod 0755 {} \;


COPY glpi.conf /etc/apache2/sites-available/
COPY downstream.php /var/www/html/glpi/inc/
COPY local_define.php /etc/glpi/
COPY php.ini /etc/php/8.2/apache2/


RUN a2dissite 000-default.conf 
RUN a2enmod rewrite 
RUN a2ensite glpi.conf 
RUN service apache2 restart 


EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
