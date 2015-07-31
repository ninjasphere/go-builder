#NAME
	go-builder

#DESCRIPTION

This docker image provides tools for performing mainly go builds. The execution environment includes:

* a fixed version of go
* a bind mount of $GOPATH/src on /data/go/src
* a bind mount of ${PWD}/bin/${GOOS}_${GOARCH} on /data/go/bin
* a bind mount of /var/run/docker.sock
* a working directory of ${PWD#${GOPATH}}
* various useful tools like docker, make, curl, etc

The intended use case of this image is to provide a workable environment for building go binaries for linux/amd64 that minimises the amount of build environment setup in the docker client itself. In particular, although GOPATH needs to be
setup (and exist in the volume that is shared with the docker container), there is no need to install go or make or other such tools on the docker client.

#INSTALLATION

Install /usr/local/bin/go-builder with the following command

```
docker run --rm ninjasphere/go-builder | bash
```

#RUNNING

To run a build command, execute:

```
go-builder {build-cmd} {args..}
```

To start a bash shell within the container:

```
go-builder bash
```

#TODO

* ensure support for non linux/amd64 support works
* add support for cross-compilation of C binaries

#REVISION

##1.0

* initial release