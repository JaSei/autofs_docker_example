#Example Dockerfile of application with autofs (automount)

##Use case
We have applications which move files from SMB servers. This configuration allow using autofs (automount) as background process in container.

##Base image
This example use centos:7 base image, but principle this works on all base images.

The most important part is install `autofs` and `cifs-utils` packages and configure it:
```
echo -e "+auto.master\n/net\t/etc/auto.cifs\t--timeout 60" > /etc/auto.master; \
echo -e "*\t-fstype=autofs,-Dhost=&\tfile:/etc/auto.cifs.sub" > /etc/auto.cifs; \
echo -e "*\t-fstype=cifs,user=${user},pass=${pass},domain=${domain},uid=${uid},gid=${gid}\t://${host}/&" > /etc/auto.cifs.sub
```

For background run of automount is used own entrypoint.sh

##docker run
`docker run --rm -it --cap-add ALL autofs_docker_example bash`
To mount a FUSE based filesystem, you need set right --cap-add (https://docs.docker.com/engine/reference/run/#/runtime-privilege-and-linux-capabilities)
