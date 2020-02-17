# IMAGE: Get the base image for Liberty
FROM open-liberty

# Add Infinispan config
COPY wlp/config/jvm.Infinispan.options /opt/ol/wlp/usr/servers/defaultServer/jvm.options

# Add Infinispan jars
RUN mkdir /opt/ol/wlp/usr/shared/resources/infinispan
COPY wlp/usr/shared/resources/infinispan/*.jar /opt/ol/wlp/usr/shared/resources/infinispan/
USER root
RUN chown 1001:0 /opt/ol/wlp/usr/shared/resources/infinispan/*.jar
USER 1001

# Add server.xml
COPY wlp/config/server.Infinispan.xml /config/server.xml
USER root
RUN chown 1001:0 /config/server.xml
USER 1001

#RUN configure.sh

# BINARIES: Add in all necessary application binaries
ADD target/ss-web.war /opt/ol/wlp/usr/servers/defaultServer/apps
