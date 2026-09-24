#stage 1 - build the jAR(java application  runtime) using maven
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
#create JAR file
RUN mvn clean install -DskipTests=true

# stage 2 - execute the JAR file from the above stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/expensesapp.jar
CMD ["java","-jar","expensesapp.jar"]

