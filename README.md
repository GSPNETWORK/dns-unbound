# Unbound DNS Server Docker Image
DNS UNBOUND Docker

### Uso padrão

Execute este contêiner com o seguinte comando:

```console
docker run \
--name=DNS \
--detach=true \
--publish=53:53/tcp \
--publish=53:53/udp \
--restart=unless-stopped \
gspnetwork/dns-unbound
