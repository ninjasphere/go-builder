#NAME
	go-builder

#DESCRIPTION

This docker image provides tools for performing mainly go builds. The execution environment includes:

* a fixed version of go
* a bind mount of $GOPATH/src on /data/go/src
* a bind mount of ${PWD}/bin/${GOOS}_${GOARCH} on /data/go/bin
* a bind mount of /var/run/docker.sock
* a working directory of /data/go/${PWD#${GOPATH}}
* various useful tools like docker, make, curl, etc

The intended use case of this image is to provide a workable environment for building go binaries for linux/amd64 that minimises the amount of build environment setup in the docker client itself. In particular, although GOPATH needs to be
setup (and exist in the volume that is shared with the docker container), there is no need to install go or make or other such tools on the docker client.

#INSTALLATION

Install /usr/local/bin/go-builder with the following command

```
docker run --rm ninjasphere/go-builder | bash
```

go-builder will run its arguments as a command within the docker container after establishing various bind mounts, environment variables and the working directory.

#RUNNING

To run a build command, execute:

```
go-builder {build-cmd} {args..}
```

To start a bash shell within the container:

```
go-builder bash
```

The output of 'go install' will be written to ${GOPATH}/bin/${GOOS}_${GOARCH} in the docker client.

#VARIANTS

It might be that ninjasphere/go-builder doesn't contain all the tools you need. In this case, you can create a derivative
of ninjasphere/go-builder and called, say, acme/foobar. To install the foobar tool, run:

```
docker run -e BUILDER_IMAGE=acme/foobar --rm acme/foobar | bash
```

This will install /usr/local/bin/foobar which will run a container based on the acme/foobar image.

To vary the name of the installed binary, add a -e BUILDER_BIN argument to specify where the installation should occur. By default, the script will be installed in /usr/local/bin/

#RESTRICTIONS

* GOPATH must be configured in the docker client's environment.
* On Windows and OSX, GOPATH must point to a directory within the user's home directory to take advantage of the user volume mounting performed by boot2docker.
* The current working directory on the docker client must be a subdirectory of $GOPATH

#TODO

* ensure that non linux/amd64 go builds work as expected.
* add support for cross-compilation of C binaries.

#REVISION

##1.2
* build go tools for windows/amd64, darwin/amd64 and linux/arm to image

##1.1
* support for build tool images called something other than ninjasphere/go-builder

##1.0
* initial release