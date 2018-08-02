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

`docker run -p 80:8080 opentripplanner-switzerland --router switzerland --server`

Access OpenTripPlanner at `http://localhost:80/`.

You can also run with the --analyst option to use OTP Analyst features, or run without any optional arguments to see all available command line options.
