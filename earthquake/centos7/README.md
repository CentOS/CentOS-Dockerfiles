dockerfiles-centos-earthquake
========================

CentOS 7 dockerfile for earthquake (terminal-based Twitter client:
https://github.com/jugyo/earthquake)

Installation
-----

Clone Dockerfile somewhere and run:

    $ sudo docker build -t earthquake:centos7 .

    On docker 1.0.0+:
    $ sudo docker run -t -i earthquake:centos7 --name=earthquake

Could be run using TMux or GNU Screen

Plugins
-----

In order to install plugins just follow the steps from earthquake manuals;
Docker will keep those changed/new files untouched.
