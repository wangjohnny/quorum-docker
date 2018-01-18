FROM ubuntu:16.04
MAINTAINER Wang Jian <wangjian@wancloud.io>

ENV GO_REL go1.7.3.linux-amd64.tar.gz
ENV CONSTELLATION_REL constellation-0.2.0-ubuntu1604
ENV PATH $PATH:/usr/local/go/bin

ADD sources.list /etc/apt/sources.list

# install build deps
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:ethereum/ethereum
RUN apt-get update && apt-get install -y wget git build-essential libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

RUN cd /root

# install golang
RUN wget -q http://qa-wxtrust-jws.wancloud.io/${GO_REL} && tar -xvzf ${GO_REL}
RUN mv go /usr/local/go
RUN rm ${GO_REL}

# install constellation
RUN wget -q http://qa-wxtrust-jws.wancloud.io/$CONSTELLATION_REL.tar.xz && tar xfJ $CONSTELLATION_REL.tar.xz
RUN cp $CONSTELLATION_REL/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
RUN rm -rf $CONSTELLATION_REL && rm -rf $CONSTELLATION_REL.tar.xz

# make/install quorum
RUN git clone https://github.com/jpmorganchase/quorum.git
RUN cd quorum && git checkout tags/v2.0.0 && make all && cp build/bin/geth /usr/local/bin && cp build/bin/bootnode /usr/local/bin

# install Porosity
RUN wget -q http://qa-wxtrust-jws.wancloud.io/porosity
RUN mv porosity /usr/local/bin && chmod 0755 /usr/local/bin/porosity

RUN cd /
RUN git clone https://github.com/jpmorganchase/quorum-examples
