FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install --yes --no-install-recommends \
            gnupg \
            software-properties-common \
            wget

RUN add-apt-repository --enable-source \
    "deb http://yuma123.org/repos/apt/debian stretch main"

RUN wget -O - http://yuma123.org/repos/yuma123.gpg.key \
    | apt-key add

# combine update and install into one command line to also get an updated
# package list for installing new yangcli versions in docker builds with
# enabled cache
RUN apt-get update && \
    apt-get install --yes \
            yangcli=2.11-0

CMD if [ -n "$READLINE_INIT" ] ; then \
        echo "$READLINE_INIT" > ~/.inputrc \
    ; fi && yangcli
