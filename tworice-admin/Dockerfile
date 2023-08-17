FROM java:8
LABEL authors="TwoRice"
# 将Spring Boot JAR文件复制到容器中
COPY target/tworice-admin-1.0.jar app.jar
EXPOSE 88
# 启动应用程序
CMD ["java", "-jar", "app.jar"]