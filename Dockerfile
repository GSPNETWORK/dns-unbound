#Imagem de Origem
FROM debian

# Atualizacao dos pacotes e instalacao do unbound.
RUN apt-get update && apt-get -y install unbound dnsutils supervisor procps wget nano net-tools

# Remove pastas desnecessarias
RUN rm -fr /etc/unbound/conf.d

# Permissao pro usuario unbound
RUN chown -R unbound:unbound /etc/unbound

# Configura unbound
RUN unbound-anchor -a /var/lib/unbound/root.key ; true
RUN unbound-control-setup
RUN wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /etc/unbound/named.cache

# Mudar pra root
RUN su -

#Reiniciar DNS
RUN service unbound restart

# Copia o arquivo de configuracao personalizado pra dentro da imagem
COPY ./unbound.conf /etc/unbound/

# Copia arquivo de configuracao do supervisor pra dentro da imagem.
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Portas Usadas pelo Container
EXPOSE 53/tcp
EXPOSE 53/udp

# Cria o volume /etc/unbound, use com -p unbound:/etc/unbound ( por exemplo )
VOLUME /etc/unbound

# Copiar o arquivo resolver.conf
COPY ./resolv.conf /etc/resolv.conf

# Comando a ser executado quando o container rodar.
CMD ["/usr/bin/supervisord"]
