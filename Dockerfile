FROM ubuntu:16.04
MAINTAINER Alex Griessel <alex.griessel@consensys.net>
ENV GOREL go1.7.3.linux-amd64.tar.gz
ENV CREL constellation-0.2.0-ubuntu1604
ENV PATH $PATH:/usr/local/go/bin

# install build deps
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update && apt-get install -y wget git build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

# install constellation
#RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.0.1-alpha/ubuntu1604.zip && unzip ubuntu1604.zip
RUN wget -q http://qa-wxtrust-jws.wancloud.io/$CREL.tar.xz && tar xfJ $CREL.tar.xz
RUN cp $CREL/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
#RUN cp ubuntu1604/constellation-enclave-keygen /usr/local/bin && chmod 0755 /usr/local/bin/constellation-enclave-keygen
#RUN rm -rf $CREL

# install golang
RUN wget -q http://qa-wxtrust-jws.wancloud.io/${GOREL}
RUN tar -xvzf ${GOREL}
RUN mv go /usr/local/go
RUN rm ${GOREL}

# make/install quorum
RUN git clone https://github.com/jpmorganchase/quorum.git
RUN cd quorum && git checkout tags/v2.0.0 && make all &&  cp build/bin/geth /usr/local/bin && cp build/bin/bootnode /usr/local/bin

# install Porosity
RUN wget -q http://qa-wxtrust-jws.wancloud.io/porosity
RUN mv porosity /usr/local/bin && chmod 0755 /usr/local/bin/porosity

RUN cd /
RUN git clone https://github.com/jpmorganchase/quorum-examples
