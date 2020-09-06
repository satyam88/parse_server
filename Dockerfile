# Pull tomcat latest image from dockerhub
FROM tomcat:8.0.51-jre8-alpine
MAINTAINER akankshasuryavanshi73@gmail.com
# copy war file on to container
COPY ./target/parse_server.war /usr/local/tomcat/webapps
EXPOSE  8080
USER parse_server
WORKDIR /usr/local/tomcat/webapps
CMD ["catalina.sh","run"]