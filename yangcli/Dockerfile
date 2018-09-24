FROM debian:stretch-slim

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
        yangcli=2.12-0                                                      \
                                                                            \
 && apt-get clean                                                           \
 && rm -rf /var/lib/apt/lists/*

ADD yangcli-entrypoint.bash /
RUN dos2unix /yangcli-entrypoint.bash

ENTRYPOINT [ "/bin/bash", "/yangcli-entrypoint.bash" ]
