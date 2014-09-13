FROM mbentley/ubuntu-tomcat7-oracle
MAINTAINER Maksym

RUN (wget --progress=dot --no-check-certificate https://archive.apache.org/dist/lucene/solr/4.6.0/solr-4.6.0.tgz && \
	tar zxvf solr-4.6.0.tgz && rm solr-4.6.0.tgz)		
RUN (cd /opt/tomcat/lib/ && \
	cp -r /solr-4.6.0/example/solr /opt/solr && \
#	cp /solr-4.6.0/dist/solr-4.6.0.war /opt/solr/example/solr/solr.war && \
	cp /solr-4.6.0/example/lib/ext/* . && \
	cp /solr-4.6.0/example/resources/* . && \
#	cd ../bin/ && mkdir solr_home && cd solr_home/ && cp -r /solr-4.6.0/example/solr/* . && \
	cp /solr-4.6.0/dist/solr-4.6.0.war /opt/tomcat/webapps/solr.war && \
	rm /opt/solr/collection1/conf/solrconfig.xml && \
	rm /opt/solr/collection1/conf/schema.xml)

ENV JAVA_OPTS "-Dsolr.solr.home=/opt/solr/"

#ADD solr.xml /opt/tomcat7/bin/solr.xml 
ADD solrconfig.xml /opt/solr/collection1/conf/solrconfig.xml
ADD schema.xml /opt/solr/collection1/conf/schema.xml	


CMD ["/bin/sh", "-e", "/usr/local/bin/run"]
