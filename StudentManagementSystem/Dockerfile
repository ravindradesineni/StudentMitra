FROM tomcat:10.1-jdk21-temurin

# Remove Tomcat's default web application
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy StudentMitra as the root application
COPY StudentMitra.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat uses port 8080 inside the container
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]