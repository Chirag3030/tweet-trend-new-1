FROM openjdk:8
ADD jarstaging/com/valaxy/demo-workshop/2.1.2
ENTRYPOINT ["java", "-jar", "demo-workshop.jar"]
# dockerfile
