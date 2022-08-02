FROM tomcat:9.0

#COPY server.xml /usr/local/tomcat/conf/
#COPY catalina.policy /usr/local/tomcat/conf/
COPY sample.war /usr/local/tomcat/webapps/ROOT.war
#COPY telemetri.json /usr/local/tomcat/
#COPY license.bin /usr/local/tomcat/
#COPY netstat /usr/bin/netstat

ADD lib /usr/local/lib
ADD keys /usr/local/tomcat/keystore

USER root
RUN useradd -rm tomcat
RUN mkdir -p /usr/local/tomcat/webapps/ROOT
RUN mkdir -p /uploads/updates
RUN mkdir -p /uploads/reports
RUN chown -R $(id tomcat -u):$(id tomcat -g) /usr/local/tomcat && chmod -R a+rwx /usr/local/tomcat
RUN chown -R $(id tomcat -u):$(id tomcat -g) /uploads && chmod -R a+rwx /uploads


USER tomcat

# Prevents data leaks between requests
RUN CATALINA_OPTS="$CATALINA_OPTS -Dorg.apache.catalina.connector.RECYCLE_FACADES=true"

CMD ["catalina.sh", "run", "-security"]
