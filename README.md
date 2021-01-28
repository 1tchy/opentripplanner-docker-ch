# OpenTripPlanner Docker for Switzerland

## Run OpenTripPlanner with docker-compose

If you have [docker-compose](https://docs.docker.com/compose/install/) installed, you can simply run from terminal
within the project root-directory:

```bash
docker-compose up
# OR
docker-compose up -d # to run it detached in background
```

## Build container

`docker build -t opentripplanner-switzerland .`

## Run container

`docker run -p 80:8080 opentripplanner-switzerland --router switzerland --server --analyst`

Access OpenTripPlanner at `http://localhost:80/`.

You can also run with the --analyst option to use OTP Analyst features, or run without any optional arguments to see all available command line options.

## Error handling

If the container does not build or start but returns something like:
```bash
INFO (OpenStreetMapModule.java:161) Gathering OSM from provider: AnyFileBasedOpenStreetMapProviderImpl(/var/otp/graphs/switzerland/switzerland-latest.osm.pbf)
Killed
```
You probably need to give Docker more resources (like 10 GB memory) in its preferences.
