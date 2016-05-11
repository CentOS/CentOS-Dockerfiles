# OpenShift Source-to-image builder for nginx

## Basic use case

Have a git repo with a directory `html` (or `NGINX_STATIC_DIR`), in which all
static files to serve are.

s2i-nginx will take all files within, copy them into the docker image and take
a basic nginx config that will simply serve these files.

If there is no `html` directory, it will just copy all files in the repo.
In that case you will not be able to customize the nginx config.


## Configuring nginx

You can supply a nginx.conf-snippet that will be used by the built container.

If there is a directory `conf.d` containing (possibly multiple) nginx `server`
snippets these will be used.  It will _not_ copy the default  config, so be
sure to include the right files. See `etc/nginx.server.sample.conf` for the
default config.


## Auxiliary files

You can put auxiliary files in a directory `aux` (or `NGINX_AUX_DIR`) to copy
them to the resulting image, e.g. htpasswd files.

These will be copied to `/opt/app-root/etc/aux`.


## Environment variables

There are some environment variables you can set to influence **build** behavior.

`NGINX_STATIC_DIR` sets the repo subdir to use for static files, default
`html`.

Either `NGINX_CONF_FILE` sets a config snippet to use or `NGINX_CONF_DIR`
will copy config from this dir (defaults to `conf.d`).

`NGINX_AUX_DIR` sets the aux directory for auxiliary files.

## Acknowledgments

This is based on work that Tobias Florek did before. Thanks!
