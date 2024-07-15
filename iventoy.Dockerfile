FROM "alpine:3.20"
RUN apk add --no-cache --upgrade grep bash
CMD /bin/bash -c
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk
RUN apk add libc6-compat
RUN apk add --force-overwrite glibc-2.35-r1.apk
ADD iventoy-1.0.20-linux-free.tar.gz /app
RUN mv /app/iventoy-1.0.20 /var/iventoy
#DHCP Server Port
EXPOSE 67/udp
EXPOSE 68/udp
#TFTP Server Port
EXPOSE 69/udp
#iVentoy GUI HTTP Server Port
EXPOSE 26000/tcp
#iVentoy PXE Service HTTP Server Port
EXPOSE 16000/tcp
#NBD Server Port
EXPOSE 10809/tcp

SHELL ["/bin/bash", "-c "]
ENTRYPOINT ["/bin/bash", "-c" , "cd /var/iventoy && /bin/bash ./iventoy.sh start && tail -f /dev/null"]