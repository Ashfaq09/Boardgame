FROM maven:3-amazoncorretto-17 AS builder
COPY . /boardgame
RUN cd /boardgame && mvn package

FROM amazoncorretto:11-alpine3.18-jdk
LABEL author="Ashfaq"
LABEL Project="Board Game"
ENV USERNAME="boardgame"
ENV HOMEDIR="/boardgame"
COPY --from=builder --chown=${USERNAME}:${USERNAME} /boardgame/target/*.jar ${HOMEDIR}/*.jar
RUN adduser -h ${HOMEDIR} -s /bin/sh -D ${USERNAME}
WORKDIR /boardgame
USER boardgame
EXPOSE 8080
CMD [ "java","-jar","*.jar" ]
