FROM phusion/passenger-ruby20:0.9.12
MAINTAINER Maksym <iviakciivi@gmail.com>

ENV HOME /root

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down

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

# download project and put it in the right folder
RUN (cd /home/app/ && \
        git clone -q -b master_keywords https://mlushpenko:maxfreedom12369874@github.com/mikeg250/sitepicks3.git && \                          
        mkdir -p /home/app/apps/sitepicks/current/ && \
	cp -r sitepicks3/* /home/app/apps/sitepicks/current/ && \                               
        rm -rf sitepicks3/)                                                                                                                    

# install gems
RUN (cd /home/app/apps/sitepicks/current/ &&\                                                                                                            
	bundle install --quiet --clean --without development test && bundle update rake && \
        mv /home/app/apps/sitepicks/current/config/database.example.yml /home/app/apps/sitepicks/current/config/database.yml)

# script to run rake db:migrate/seed/sunsport:solr:reindex
RUN mkdir -p /etc/my_init.d
ADD prepare.sh /etc/my_init.d/prepare.sh

# update yml files with proper hosts to connect to db, cache and solr
RUN (sed -i "s/production:/production:\n  host: <%= ENV['DB_PORT_5432_TCP_ADDR'] %>/g" /home/app/apps/sitepicks/current/config/database.yml && \                         
     sed -i "s/localhost/<%= ENV['SOLR_PORT_8080_TCP_ADDR'] %>/g" /home/app/apps/sitepicks/current/config/sunspot.yml && \
     sed -i "s/:dalli_store,/:dalli_store, ENV['CACHE_PORT_11211_TCP_ADDR'] + \":\" + ENV['CACHE_PORT_11211_TCP_PORT'],/g" /home/app/apps/sitepicks/current/config/environments/production.rb)                

#remove default nginx app https://github.com/phusion/passenger-docker/issues/33
RUN rm -rf /etc/nginx/sites-enabled/default

# config files for nginx to run our app
ADD main_part.conf /etc/nginx/main.d/main_part.conf
ADD http_part.conf /etc/nginx/conf.d/http_part.conf
ADD sitepicks.conf /etc/nginx/sites-enabled/sitepicks.conf
# Nginx erases all env variables upon start, so we have to add their names in file
ADD link_env_variables.conf /etc/nginx/main.d/link_env_variables.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

