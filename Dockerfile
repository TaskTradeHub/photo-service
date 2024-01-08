FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY /src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package

FROM openjdk:17
COPY --from=build /app/target/*.jar application.jar
EXPOSE 8083
ENTRYPOINT ["java","-jar", "application.jar"]