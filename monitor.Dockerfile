FROM openjdk:8-jre
WORKDIR /app
COPY ./RuoYi-Cloud/ruoyi-visual/ruoyi-monitor/target/ruoyi-visual-monitor.jar /app/ruoyi-visual-monitor.jar
ENTRYPOINT ["java","-jar","ruoyi-visual-monitor.jar"]
