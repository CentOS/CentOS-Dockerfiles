CentOS-Dockerfiles
==================

This repository provides Dockerfiles for use with CentOS. Popular implementations here will be published to the CentOS namespace in the docker index.

## Contribution Guidelines

Each Dockerfile should contain a README that includes the following:

 * Version of CentOS and Docker that it was built/tested against
 * Instructions for building the Docker image

--
    For example: docker build --rm=true -t my/image .
--

 * Instructions for running the image, including examples for persistent data, port mapping, etc.
 * Examples for testing and/or validating the functionality of the image.
 * Do not include executable scripts. Provide them and mark them as executable in the Dockerfile

--
    ADD ./script.sh /usr/bin/
    RUN chmod -v +x /usr/bin/script.sh
--

 * If creating a container for a specific language, specify the version of that language.
 * If yum is used during the build process, run a clean afterwards to reduce the image size.

## Building All The Things

An example of building all images found within this git repository can be done
with the following two bash for loops from the base dir of your git clone:

--
```bash
# Building everything from centos:centos6 base image
for dir in ./*/centos6
do
    pushd $dir &> /dev/null
        # tmp var for short dirname
        tmp=$(dirname $dir)

        # strip all characters leading up to and including '/'
        appname=${tmp##*/}
        disttag=${dir##*/}

        docker build -t $USER/${appname}:${disttag} .
    popd &> /dev/null;
done

# Building everything from centos:centos7 base image
for dir in ./*/centos7
do
    pushd $dir &> /dev/null
        # tmp var for short dirname
        tmp=$(dirname $dir)

        # strip all characters leading up to and including '/'
        appname=${tmp##*/}
        disttag=${dir##*/}

        docker build -t $USER/${appname}:${disttag} .
    popd &> /dev/null
done
```
--

You'll notice that the appname/disttag structure is laid out on purpose, so if
you would prefer to only build a single image this can be done by either
following the specific README.md contained with the Dockerfile or with the
below guideline:

```bash
# $appname and $disttag should be something along the lines of 'httpd' and 
# 'centos7' respectively
cd $appname/$disttag

docker build -t $USER/${appname}:${disttag} .
```

--

## Notes

Known issues:

 * None at this time.
