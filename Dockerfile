# This is based on jaysonsantos/docker-minecraft-ftb-direwolf20-1.10

FROM java:8

MAINTAINER June Tate-Gans <june@theonelab.com>

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \
	wget -c  https://media.forgecdn.net/files/2534/202/FTB+Presents+Direwolf20+1.12-1.12.2-1.9.0-Server.zip -O ftb-server.zip && \
	unzip ftb-server.zip && \
	rm ftb-server.zip && \
	bash -x FTBInstall.sh && \
	chown -R minecraft /tmp/feed-the-beast

USER minecraft
EXPOSE 25565 25575
ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start
ENV JVM_OPTS -Xms4096m -Xmx4096m
