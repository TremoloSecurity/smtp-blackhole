FROM python:3.7-slim

MAINTAINER Tremolo Security, Inc. - Docker <docker@tremolosecurity.com>

LABEL io.k8s.description="Blackhole" \
      io.k8s.display-name="Blackhole" 

RUN set -xe ; \
    groupadd -r blackhole -g 433 && \
    useradd -u 431 -r -g blackhole -d /usr/local/blackhole -s /sbin/nologin -c "Blackhole image user" blackhole

ARG BLACKHOLE_VERSION=2.1.19
RUN set -xe ; \
    pip install --no-cache-dir blackhole==${BLACKHOLE_VERSION}

COPY bh-config.txt /usr/local/blackhole/

USER 431

CMD ["blackhole","-c","/usr/local/blackhole/bh-config.txt","-d"]
