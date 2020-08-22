FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD target/bank-service-0.0.1-SNAPSHOT.jar bank-service.jar
RUN sh -c 'touch /bank-service.jar'
ENTRYPOINT ["java","-jar","/bank-service.jar"]
EXPOSE 8083
