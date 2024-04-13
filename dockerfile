FROM openjdk:8
COPY jarstaging/com/valaxy/demo-workshop/demo-workshop-2.1.2.jar /demo-workshop.jar
ENTRYPOINT ["java", "-jar", "/demo-workshop.jar"]
# dockerfile
