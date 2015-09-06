FROM dockerizedrupal/base-debian-jessie:1.0.3

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

EXPOSE 9000

ENTRYPOINT ["/src/entrypoint.sh", "run"]
