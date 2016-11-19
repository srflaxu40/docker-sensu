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

