FROM openjdk:8-jre
ARG MODULES_NAME system
WORKDIR /app
COPY ./ruoyi-modules/ruoyi-${MODULES_NAME}/target/ruoyi-modules-${MODULES_NAME}.jar /app/ruoyi-modules-${MODULES_NAME}.jar
ENTRYPOINT ["java","-jar","ruoyi-modules-${MODULES_NAME}.jar"]
