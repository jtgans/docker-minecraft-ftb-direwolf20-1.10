docker-minecraft-ftb-direwolf20-1.10
===============

This docker image provides a Minecraft Server, based on the direwolf20 1.12 Feed
The Beast modpack. It was forked from jasonsantos/minecraft-ftb-direwolf20-1.10,
but updated to run 1.12 instead.

To simply use the latest stable version, run:

    docker run -d -p 25565:25565 jtgans/minecraft-ftb-direwolf20-1.12

where the default server port, 25565, will be exposed on your host machine. If
you want to serve up multiple Minecraft servers or just use an alternate port,
change the host-side port mapping such as:

    docker run -p 25566:25565 ...

will service port 25566.

Speaking of multiple servers, it's handy to give your containers explicit names
using `--name`, such as

    docker run -d -p 25565:25565 --name minecraft jtgans/minecraft-ftb-direwolf20-1.12

With that you can easily view the logs, stop, or re-start the container:

    docker logs -f minecraft
        ( Ctrl-C to exit logs action )

    docker stop minecraft

    docker start minecraft


## Attaching data directory to host filesystem

In order to persist the Minecraft data, which you *probably want to do for a
real server setup*, use the `-v` argument to map a directory of the host to
``/data``:

    docker run -d -v /path/on/host:/data -p 25565:25565 jtgans/minecraft-ftb-direwolf20-1.12

When attached in this way you can stop the server, edit the configuration under
your attached ``/path/on/host`` and start the server again with `docker start
CONTAINERID` to pick up the new configuration.


## Server configuration

It's expected that you'll mount a `server.properties` file at
``/data/server.properties`` containing everything you want to adjust. If you
would prefer to have RCON enabled, you'll want to set the env var
`RCON_PASSWORD` to something sensible.

Under Kubernetes, you can specify the entire server.properties file as a
configmap, and the RCON_PASSWORD as a secret.
