FROM openjdk:11

Add jarstaging/com/valaxy/demo-workshop/2.1.4/demo-workshop-2.1.4.jar demo-workshop.jar

ENTRYPOINT [ "java" , "-jar" , "demo-workshop.jar" ]