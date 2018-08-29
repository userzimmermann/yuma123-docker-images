FROM resin/rpi-raspbian:stretch

RUN apt-get update                                                          \
 && apt-get install --yes --no-install-recommends                           \
        gnupg                                                               \
        wget                                                                \
                                                                            \
 && echo "deb http://yuma123.org/repos/apt/debian stretch main"             \
 >> /etc/apt/sources.list                                                   \
                                                                            \
 && wget -O - http://yuma123.org/repos/yuma123.gpg.key                      \
  | apt-key add                                                             \
                                                                            \
 && apt-get clean                                                           \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          \
 && apt-get install --yes --no-install-recommends                           \
        dos2unix                                                            \
        netconfd=2.11-0                                                     \
        netconfd-module-ietf-interfaces=2.11-0                              \
        netconfd-module-ietf-system=2.11-0                                  \
        openssh-server                                                      \
        openssl                                                             \
                                                                            \
 && apt-get clean                                                           \
 && rm -rf /var/lib/apt/lists/*

ADD netconfd-entrypoint.bash /
RUN dos2unix /netconfd-entrypoint.bash

ENV NETCONF_PORT=830                                                        \
                                                                            \
    NETCONF_USER=yuma123                                                    \
    NETCONF_PASSWORD="yuma123"                                              \
                                                                            \
    NETCONF_MODULES="ietf-interfaces ietf-system"                           \
    NETCONF_STARTUP_CFG_FILE="startup-cfg.xml"                              \
                                                                            \
    NETCONF_LOG_LEVEL=info

ENTRYPOINT [ "/bin/bash", "/netconfd-entrypoint.bash" ]
