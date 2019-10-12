# Kyoto Tycoon Docker Container with Memcache
To know about what kyoto tycoon is please go ahead to the [project page](https://github.com/alticelabs/kyoto "Project on github").
## Build container Locally : 
docker build -t yourcontainertag -f Dockerfile .
## Run the cache kyoto
docker run -p 1978:1978 -p 11401:11401-d --name cache -v /your/directory:/var/ktserver/:rw registry.centos.org/centos/kyoto-tycoon:latest
## Storing data into kyoto tycoon
docker run --rm --link cache:kt registry.centos.org/centos/kyoto-tycoon:latest  ktremotemgr set -host kt key1 value1
## Listing data in kyoto tycoon
docker run --rm --link cache:kt registry.centos.org/centos/kyoto-tycoon:latest ktremotemgr list -host kt
## Updates
Until we have rpms available for both kyoto cabinet and kyoto tycoon, the updates will have to be tracked by looking at the source release urls at

 1. http://fallabs.com/kyotocabinet/pkg/
 2. http://fallabs.com/kyototycoon/pkg/