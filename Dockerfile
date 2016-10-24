FROM centos:7

ARG host
ARG user=guest
ARG pass=guest
ARG domain=WORKGROUP
ARG uid=1000
ARG gid=1000

#autofs
RUN yum install -y autofs cifs-utils
RUN echo -e "+auto.master\n/net\t/etc/auto.cifs\t--timeout 60" > /etc/auto.master; \
    echo -e "*\t-fstype=autofs,-Dhost=&\tfile:/etc/auto.cifs.sub" > /etc/auto.cifs; \
    echo -e "*\t-fstype=cifs,user=${user},pass=${pass},domain=${domain},uid=${uid},gid=${gid}\t://${host}/&" > /etc/auto.cifs.sub
RUN chmod -x /etc/auto.*
RUN mkdir /net

WORKDIR /app
#install application

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["--help"]
