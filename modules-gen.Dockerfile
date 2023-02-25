FROM openjdk:8-jre
WORKDIR /app
COPY ./RuoYi-Cloud/ruoyi-modules/ruoyi-gen/target/ruoyi-modules-gen.jar /app/ruoyi-modules-gen.jar
ENTRYPOINT ["java","-jar","ruoyi-modules-gen.jar"]