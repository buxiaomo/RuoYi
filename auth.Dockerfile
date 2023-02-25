FROM openjdk:8-jre
WORKDIR /app
COPY ./RuoYi-Cloud/ruoyi-auth/target/ruoyi-auth.jar /app/ruoyi-auth.jar
ENTRYPOINT [ "java", "-jar", "ruoyi-auth.jar"]