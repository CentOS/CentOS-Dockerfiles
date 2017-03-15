## Caddy Server Dockerfile

https://caddyserver.com

This is a dockerfile for Caddy Server. Everything is loaded into `/var/www/html` directory. The Caddyfile is put into `/etc/caddy/Caddyfile`

By default, content present inside `/var/www/html` will be served over web on the port 2015. Ports 80, 443, 8080 and 8443 are also exposed. Mount your content here with appropriate permissions.

### Caddy server plugins installed by default:
 
 1. DNS
 2. expire
 3. git
 4. minify
 5. search
 6. cloudfare
 7. digitalocean
 8. dyn
 9. googlecloud
 10. upload
 11. jwt
 12. filemanager

### Caddy Server Configuration

A default caddyserver config file is loaded into container. To overwrite default caddy file in a built container, you can mount your own at `/etc/caddy/Caddyfile`,
however you are responsible for setting appropriate permissions.

Some of the plugins are installed, but not configured by default as they may have application specific settings. 

You can read more about how to create your own Caddyfile at the [caddyfile Syntax documentation](https://caddyserver.com/docs/caddyfile "Caddyfile Docs").

### Example with your own caddyfile:

 `$ docker run -d -v $(pwd)/Caddyfile:/etc/caddy/Caddyfile -v $(pwd)/mysite:/var/www/html --name=mycaddy registry.centos.org/caddyserver/caddyserver:latest`
 
**Note** :
For docker volume mounts using -v, you might encounter issues with selinux permission denies. Please take [nesessary steps](http://www.projectatomic.io/blog/2015/06/using-volumes-with-docker-can-cause-problems-with-selinux/) to avoid any issues
