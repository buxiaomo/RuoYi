FROM openjdk:8-jre
WORKDIR /app
COPY ./RuoYi-Cloud/ruoyi-gateway/target/ruoyi-gateway.jar /app/ruoyi-gateway.jar
ENTRYPOINT [ "java", "-jar", "ruoyi-gateway.jar"]