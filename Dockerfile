FROM tomcat:7-jre7
MAINTAINER Mirnes Omerkic <mirnes.omerkic@atlantbh.com>

ADD ./petclinic.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]