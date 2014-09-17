#!/bin/sh
cd /home/app/apps/sitepicks/current
export RAILS_ENV=production 
rake db:migrate
rake db:seed
rake sunspot:solr:reindex
rake assets:precompile
