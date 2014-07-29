dockerfiles-centos-couchdb
========================

CentOS 6 dockerfile for couchdb

Get the version of Docker:

```
# docker version
```

To build:

Copy the sources down, then -

```
# docker build -rm -t <username>/couchdb:centos6 .
```

To run:

```
# docker run -d -p 5984:5984 <username>/couchdb:centos6
```

Test:

```
# curl -X PUT http://localhost:5984/test/
{"error":"file_exists","reason":"The database could not be created, the file already exists."}
```

```
# curl -X GET http://localhost:5984/test/
{"db_name":"test","doc_count":0,"doc_del_count":0,"update_seq":0,"purge_seq":0,"compact_running":false,"disk_size":79,"data_size":0,"instance_start_time":"1387384723608413"}
```


