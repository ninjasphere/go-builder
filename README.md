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

