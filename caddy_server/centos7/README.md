## Caddy Server Dockerfile
https://caddyserver.com

This is a dockerfile for Caddy Server. Everything is loaded into `/srv` directory. The Caddyfile is put into `/srv/config/Caddyfile`

By default, content present inside `/srv/public` will be served over web on the port 2015. Ports 80, 443, 8080 and 8443 are also exposed. Mount your content here with appropriate permissions.

To overwrite default caddy file in a built container, you can mount your own at `/srv/config/Caddyfile`, however you are responsible for setting appropriate permissions.

**Note** :
For docker volume mounts using -v, you might encounter issues with selinux permission denies. Please take [nesessary steps](http://www.projectatomic.io/blog/2015/06/using-volumes-with-docker-can-cause-problems-with-selinux/) to avoid any issues