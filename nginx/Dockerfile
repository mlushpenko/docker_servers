FROM phusion/passenger-ruby20:0.9.12
MAINTAINER Maksym <iviakciivi@gmail.com>

ENV HOME /root

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down
#RUN rm -f /etc/service/memcached/down

ADD sitepicks.conf /etc/nginx/sites-enabled/sitepicks.conf
ADD main_part.conf /etc/nginx/main.d/main_part.conf
ADD http_part.conf /etc/nginx/conf.d/http_part.conf

#ADD id_rsa /tmp/id_rsa
#RUN cat /tmp/id_rsa >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa
#EXPOSE 22

RUN apt-get -y update
RUN apt-get -y install imagemagick wget 
RUN cd /usr/local/bin 
RUN wget https://wkhtmltopdf.googlecode.com/files/wkhtmltoimage-0.11.0_rc1-static-amd64.tar.bz2 
RUN tar xvjf wkhtmltoimage-0.11.0_rc1-static-amd64.tar.bz2 
RUN rm wkhtmltoimage-0.11.0_rc1-static-amd64.tar.bz2 
RUN mv wkhtmltoimage-amd64 wkhtmltoimage 
RUN wget https://phantomjs.googlecode.com/files/phantomjs-1.9.2-linux-x86_64.tar.bz2 
RUN tar xvjf phantomjs-1.9.2-linux-x86_64.tar.bz2 
RUN rm phantomjs-1.9.2-linux-x86_64.tar.bz2
RUN mv phantomjs-1.9.2-linux-x86_64/bin/phantomjs /usr/bin/phantomjs




RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

