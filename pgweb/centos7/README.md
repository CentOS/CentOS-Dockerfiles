# docker-pgweb

Runs [pgweb](https://github.com/sosedoff/pgweb), a web-based PostgreSQL database browser.

## How to use

Use with --link (postgres as internal hostname), expose port 8080:

```
docker run --rm -p 8080:8080 --link POSTGRES_CONTAINER:postgres centos/pgweb
```

Alt. connect pgweb to an existing docker network, expose port 8080:  

````
docker run --rm -p 8080:8080 --net EXISTING_DOCKER_NETWORK centos/pgweb
```

