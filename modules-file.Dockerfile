FROM openjdk:8-jre
WORKDIR /app
COPY ./RuoYi-Cloud/ruoyi-modules/ruoyi-file/target/ruoyi-modules-file.jar /app/ruoyi-modules-file.jar
ENTRYPOINT [ "java", "-jar", "ruoyi-modules-file.jar"]