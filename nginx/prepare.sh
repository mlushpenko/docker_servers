#!/bin/sh
cd /home/app/apps/sitepicks/current 
rake db:migrate RAILS_ENV=production
rake db:seed RAILS_ENV=production
rake sunspot:solr:reindex RAILS_ENV=production 
