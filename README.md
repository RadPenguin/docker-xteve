# docker-xteve

Build an [xteve](hhttps://www.xteve.de/) docker container.

## Usage
```
docker create \
  --name=xteve \
  --env TZ="America/Edmonton" \
  --volume $( pwd )/config:/config \
  radpenguin/xteve
```

## Parameters
```
--env TZ - the timezone to use for the cron and log. Defaults to `America/Edmonton`
--volume /config - config folder for xteve
```

It is based on alpine linux. For shell access while the container is running, `docker exec -it xteve /bin/bash`.
