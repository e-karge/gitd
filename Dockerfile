FROM alpine:3.3

RUN \
  sed -i  '1 {p; s:/v3.3/main$:/edge/testing:}' /etc/apk/repositories &&\
  cat /etc/apk/repositories &&\
  apk update &&\
  apk upgrade &&\
  apk add git git-gitweb lighttpd dropbear runit &&\
  rm -r /var/cache/apk/* &&\
  :

RUN \
  mkdir -p /etc/dropbear &&\
  adduser -h /var/db/git -s /bin/sh -H -D git git &&\
  mkdir -p /var/db/git &&\
  chown git:git /var/db/git &&\
  printf 'git:git' | chpasswd &&\
  :

COPY runsvdir /run/runsvdir

EXPOSE 22

CMD runsvdir /run/runsvdir
