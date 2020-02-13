FROM alpine:3.3

RUN \
  # add testing for runit \
  echo @edge http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories &&\
  apk --no-cache upgrade &&\
  apk --no-cache add runit@edge git dropbear runit &&\
  :

RUN \
  mkdir -p /etc/dropbear &&\
  adduser -h /var/db/git -s /bin/sh -H -D git git &&\
  mkdir -m 0750 -p /var/db/git &&\
  mkdir -m 0700 -p /var/db/git/.ssh &&\
  chown -R git:git /var/db/git &&\
  printf 'git:git' | chpasswd &&\
  :

COPY runsvdir /run/runsvdir
COPY init /run

EXPOSE 22

ENTRYPOINT /run/init
