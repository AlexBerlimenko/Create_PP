FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY ProgramClientCode.java ojdbc8.jar ./

RUN javac -cp "./ojdbc8.jar:." ProgramClientCode.java

CMD ["java", "-cp", "./ojdbc8.jar:.", "ProgramClientCode"]
