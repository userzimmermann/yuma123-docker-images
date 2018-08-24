FROM debian:stretch

RUN apt-get update
RUN apt-get dist-upgrade --yes
RUN apt-get install --yes --no-install-recommends \
            gnupg \
            software-properties-common \
            wget

RUN add-apt-repository --enable-source \
    "deb http://yuma123.org/repos/apt/debian stretch main"

RUN wget -O - http://yuma123.org/repos/yuma123.gpg.key \
    | apt-key add

RUN apt-get update
RUN apt-get install --yes \
            yangcli=2.11-0

CMD if [ -n "$READLINE_INIT" ] ; then \
        echo "$READLINE_INIT" > ~/.inputrc \
    ; fi && yangcli
