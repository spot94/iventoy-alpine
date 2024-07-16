FROM "alpine:3.20"
ARG IVENTOY_VERSION=1.0.20

RUN apk add --no-cache --upgrade grep bash
CMD /bin/bash -c
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk
#App can run only with libc6-compat and glibc-2.35-r1 together
RUN apk add libc6-compat
RUN apk add --force-overwrite glibc-2.35-r1.apk
#Download app
ADD https://github.com/ventoy/PXE/releases/download/v${IVENTOY_VERSION}/iventoy-${IVENTOY_VERSION}-linux-free.tar.gz /tmp/iventoy.tar.gz
RUN tar xvf /tmp/iventoy.tar.gz && \
    mv ./iventoy-${IVENTOY_VERSION} /var/iventoy && \
    rm -rf /tmp/iventoy.tar.gz

VOLUME /var/iventoy/iso /var/iventoy/data /var/iventoy/log /var/iventoy/user

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
ENTRYPOINT ["/bin/bash", "-c" , "cd /var/iventoy && /bin/bash ./iventoy.sh -R start && tail -f log/log.txt"]
