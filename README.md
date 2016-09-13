#Example Dockerfile of application with autofs (automount)

##Use case
We have applications which move files from SMB servers. This configuration allow using autofs (automount) as background process in container.

##Base image
This example use centos:7 base image, but principle this works on all base images.

The most important part is install `autofs` and `cifs-utils` packages and configure it:
```
echo $'+auto.master\n/net\t/etc/auto.cifs\t--timeout 60' > /etc/auto.master; \
echo $'*\t-fstype=autofs,-Dhost=&\tfile:/etc/auto.cifs.sub' > /etc/auto.cifs; \
echo $'*\t-fstype=cifs,user=${user},pass=${pass},domain=${domain},uid=${uid},gid=${gid}\t://${host}/&' > /etc/auto.cifs.sub
```

For background run of automount is used own entrypoint.sh
