# Multi-stage build w. Maven

# Build stage and running mvn
FROM maven:3.5.2-jdk-8 AS build

COPY pom.xml /usr/src/app  
COPY . /src
WORKDIR /src
RUN mvn clean package


# Run stage
FROM openjdk:11.0.1-jre-slim-stretch
EXPOSE 8080
WORKDIR /app
ARG JAR=spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar

COPY --from=build /src/target/$JAR /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]