# docker-grafana
Small, opinionated docker image for Grafana

# Why?
I wanted smaller image, and Zabbix plugin. So here it is.
Official image is 260mb, this image just 60mb.

# How to use?
Get image with:
```
docker pull olegfedoseev/grafana
```

Then run it with:

```
docker run -d --name=grafana \
  -v /data/grafana:/var/lib/grafana \
  -e VIRTUAL_HOST=grafana.example.com \
  -e VIRTUAL_PORT=3000 \
  olegfedoseev/grafana
```
If you don't use jwilder/nginx-proxy, remove both `VIRTUAL_`. But you should use it, it's awesome :)

You also can mount custom config to /etc/grafana/config.ini via `-v /path/to/config.ini:/etc/grafana/config.ini`
