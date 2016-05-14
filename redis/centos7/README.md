dockerfiles-centos-redis
========================

CentOS 7 Dockerfile for redis

== Building to container image

Copy the sources down -

	# docker build --rm --tag <username>/redis-28-centos7 .

== Running the container

To run:

	# docker run -d -p 6379:6379 -e MASTER=true <username>/redis-28-centos7

To test:

	# nc localhost 6379

== advanced usage

If you want to get a slightly bigger redis service up, have a look at
https://github.com/kubernetes/kubernetes/tree/release-1.2/examples/redis this
container image could be used to implement that example, use `kubernetes/` for
this.

=== tl;dr

```
# Create a bootstrap master
oc create -f kubernetes/redis-master.yaml

# Create a service to track the sentinels
oc create -f kubernetes/redis-sentinel-service.yaml

# Create a replication controller for redis servers
oc create -f kubernetes/redis-controller.yaml

# Create a replication controller for redis sentinels
oc create -f kubernetes/redis-sentinel-controller.yaml

# Scale both replication controllers
oc scale rc redis --replicas=3
oc scale rc redis-sentinel --replicas=3

# Delete the original master pod
oc delete pods redis-master
```
