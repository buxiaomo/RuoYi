FROM openjdk:8-jre
ARG JAR_NAME ruoyi-auth
WORKDIR /app
COPY ./RuoYi-Cloud/${JAR_NAME}/target/${JAR_NAME}.jar /app/${JAR_NAME}.jar
ENTRYPOINT ["java","-jar","${JAR_NAME}.jar"]