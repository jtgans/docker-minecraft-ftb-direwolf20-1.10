#!/bin/bash

set -e

cd /data
cp -vrf /tmp/feed-the-beast/* .
echo "eula=true" > eula.txt

if [[ ! -z "${RCON_PASSWORD}" ]] && ! grep -q rcon.password server.properties 2>/dev/null; then
    echo "rcon.password=${RCON_PASSWORD}" >> server.properties
    sed -i -e 's/enable-rcon=false/enable-rcon=true/' server.properties
fi

java $JVM_OPTS -jar FTBserver-*.jar nogui
