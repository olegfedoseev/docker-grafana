FROM gliderlabs/alpine:3.3
MAINTAINER Oleg Fedoseev <oleg.fedoseev@me.com>

# glibc-compat layer
RUN apk --allow-untrusted --no-cache -X http://apkproxy.heroku.com/andyshinn/alpine-pkg-glibc add glibc glibc-bin

# grafana-3.0.1
RUN apk-install curl && mkdir -p /tmp/grafana/ /usr/local/grafana && \
	curl -skL https://grafanarel.s3.amazonaws.com/builds/grafana-3.0.1-.linux-x64.tar.gz | tar -zxv -C /tmp/grafana && \
	mv /tmp/grafana/grafana-3.0.1-/bin /usr/local/grafana && \
	mv /tmp/grafana/grafana-3.0.1-/conf /usr/local/grafana && \
	mv /tmp/grafana/grafana-3.0.1-/public /usr/local/grafana && \
	apk del curl && rm -rf /tmp/grafana/grafana-3.0.1-

# plugins
RUN /usr/local/grafana/bin/grafana-cli --pluginsDir /usr/local/grafana/plugins plugins install alexanderzobnin-zabbix-app && \
	/usr/local/grafana/bin/grafana-cli --pluginsDir /usr/local/grafana/plugins plugins install grafana-piechart-panel

RUN mkdir -p /var/lib/grafana
VOLUME ["/var/lib/grafana", "/etc/grafana"]

ADD config.ini /etc/grafana/config.ini

EXPOSE 3000
CMD ["/usr/local/grafana/bin/grafana-server", "-config", "/etc/grafana/config.ini", "-homepath", "/usr/local/grafana/"]
