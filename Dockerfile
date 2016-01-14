FROM alpine:3.3

RUN \
  # add testing for runit \
  sed -i '1 {p; s:/v3.3/main$:/edge/testing:}' /etc/apk/repositories &&\
  apk update &&\
  apk upgrade &&\
  apk add git git-gitweb lighttpd dropbear runit &&\
  # remove testing \
  sed -i -e '/\/edge\/testing$/ d' /etc/apk/repositories &&\
  rm -r /var/cache/apk/* &&\
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
