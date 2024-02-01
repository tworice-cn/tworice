FROM java:8
LABEL authors="TwoRice"
# 将Spring Boot JAR文件复制到容器中
COPY ./jar/tworice-admin.jar /jar/tworice-admin.jar
COPY ./config/application*.yml /config/

EXPOSE 88
# 启动应用程序
CMD ["java", "-Xmx128m","-Xms128m", "-jar", "/jar/tworice-admin.jar","--spring.config.location=file:/config/"]