FROM openjdk:8-jre
WORKDIR /app
COPY ./RuoYi-Cloud/ruoyi-modules/ruoyi-system/target/ruoyi-modules-system.jar /app/ruoyi-modules-system.jar
ENTRYPOINT ["java","-jar","ruoyi-modules-system.jar"]