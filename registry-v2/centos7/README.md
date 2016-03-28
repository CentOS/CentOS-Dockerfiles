Docker Registry v2 (aka Distribution)
========================

CentOS7 Dockerfile for Docker Registry v2

To build:
```bash
docker build -t <yourname>/registry .
```

To run:
```bash
docker run -d -p 5000:5000 <yourname>/registry
```

To use a persistent storage run it as:
```bash
docker run -d -p 5000:5000 -v /var/lib/registry:/var/lib/registry:Z <yourname>/registry
```
