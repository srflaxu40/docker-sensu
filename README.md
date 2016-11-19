# docker-sensu


# Docker things:

## Build:

* `docker build -t sensu-base .`

## Run:

* `docker run -d -p 3000:3000 -it sensu-base`

# docker-compose things:

## Build / run:

* `docker-compose up --build`

---

# Rancher:

* Deploy to rancher using the `docker-compose-rancher.yml` file:

```
rancher-compose --verbose \
                -f docker-compose-rancher.yml \
                -p sensu \
                up \
                --pull \
                --force-upgrade \
                --confirm-upgrade \
                -d
```

  * Inside the docker-compose-rancher.yml file:
    * SHA is the 7 character hash taken from the latest commit in this GitHub repo.
    * BRANCH is the branch you are in.
    * ENVIRONMENT is the respective environment.
  * DOCKER_TAG=${SHA}-${BRANCH}-${ENVIRONMENT}, and is expected to be in a DockerHub repo.

# Makefile commands:

* `make build`
* `make push`

---

# Notes:
* This repo builds all the components of sensu into one giant, fat docker container.
* Yes, I know this breaks all 12-factor, docker ephemerality, failover idioms.
* Honestly, I just wanted one Sensu container running with all the inner workings, self-contained, and without
  having to worry about failover, etc, or anything else I have run into in the Docker / Rancher realm.
* Put check JSON files under checks/, handlers under handlers/, plugins under plugins, and for those experienced
  with Sensu you know the rest...
* Modify the config.json, and notifications.json as well as the example check for your purposes...
* Oh, and don't forget to modify the docker-compose-rancher.yml for your DockerHub / Docker repo.
