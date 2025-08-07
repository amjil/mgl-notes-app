FROM openjdk:8-alpine

COPY target/uberjar/notes-sync-serv.jar /notes-sync-serv/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/notes-sync-serv/app.jar"]
