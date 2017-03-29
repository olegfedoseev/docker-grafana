FROM gliderlabs/alpine:3.4
MAINTAINER Oleg Fedoseev <oleg.fedoseev@me.com>

# glibc-compat layer
RUN apk --allow-untrusted --no-cache -X http://apkproxy.heroku.com/andyshinn/alpine-pkg-glibc add glibc glibc-bin

ENV GRAFANA_VERSION 4.0.2-1481203731
RUN apk-install curl && mkdir -p /tmp/grafana/ /usr/local/grafana && \
	curl -skL https://grafanarel.s3.amazonaws.com/builds/grafana-$GRAFANA_VERSION.linux-x64.tar.gz | tar -zxv -C /tmp/grafana && \
	mv /tmp/grafana/grafana-$GRAFANA_VERSION/bin /usr/local/grafana && \
	mv /tmp/grafana/grafana-$GRAFANA_VERSION/conf /usr/local/grafana && \
	mv /tmp/grafana/grafana-$GRAFANA_VERSION/public /usr/local/grafana && \
	apk del curl && rm -rf /tmp/grafana/grafana-$GRAFANA_VERSION

RUN mkdir -p /var/lib/grafana
VOLUME ["/var/lib/grafana", "/etc/grafana"]

ADD config.ini /etc/grafana/config.ini

EXPOSE 3000
CMD ["/usr/local/grafana/bin/grafana-server", "-config", "/etc/grafana/config.ini", "-homepath", "/usr/local/grafana/"]
