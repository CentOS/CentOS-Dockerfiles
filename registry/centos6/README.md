dockerfiles-centos-registry
========================

CentOS6 dockerfile for docker registry

Get the version of Docker:

	# docker version

To build:

	# docker build -rm -t <yourname>/registry:centos6 .

To run:

	# docker run -d -p 5000:5000 <yourname>/registry:centos6

To use a separate data volume for /var/lib/docker-registry (recommended, to
allow image update without losing registry contents):

Create a data volume container: (it doesn't matter what image you use
here, we'll never run this container again; it's just here to
reference the data volume)

	# docker run --name=registry-data -v /var/lib/docker-registry registry:centos6

And now create the registry application container:

	# docker run --name=registry  -d -p 5000:5000 --volumes-from=registry-data <yourname>/registry:centos6

Test it...

```
# docker tag <yourname>/registry:centos6 localhost:5000/<yourname>/registry:centos6
# docker push localhost:5000/<yourname>/registry:centos6
```
