FROM eclipse-temurin:17-jdk-alpine

ENV APP_HOME /app
ENV JAVA_OPTS=""

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY PhoneShopService/target/PhoneShopService-0.0.1-SNAPSHOT.jar $APP_HOME/app.jar

EXPOSE 8080

CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]