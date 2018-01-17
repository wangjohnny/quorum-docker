FROM ubuntu:16.04
MAINTAINER Alex Griessel <alex.griessel@consensys.net>
ENV GOREL go1.7.3.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin

RUN apt-get update &&  apt-get install -y
RUN apt-get install -y software-properties-common unzip wget git make gcc libsodium-dev build-essential libdb-dev zlib1g-dev libtinfo-dev sysvbanner wrk psmisc
RUN add-apt-repository -y ppa:ethereum/ethereum &&  apt-get update && apt-get install -y solc
#RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.0.1-alpha/ubuntu1604.zip && unzip ubuntu1604.zip
RUN wget -q http://qa-wxtrust-jws.wancloud.io/constellation-0.2.0-ubuntu1604.tar.xz && tar xfJ constellation-0.2.0-ubuntu1604.tar.xz

RUN cp ubuntu1604/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
#RUN cp ubuntu1604/constellation-enclave-keygen /usr/local/bin && chmod 0755 /usr/local/bin/constellation-enclave-keygen
#RUN rm -rf ubuntu1604.zip ubuntu1604
RUN wget -q http://qa-wxtrust-jws.wancloud.io/${GOREL}
RUN tar -xvzf ${GOREL}
RUN mv go /usr/local/go
RUN rm ${GOREL}

RUN git clone https://github.com/jpmorganchase/quorum.git
RUN cd quorum && git checkout tags/v2.0.0 && make all &&  cp build/bin/geth /usr/local/bin && cp build/bin/bootnode /usr/local/bin

wget -q http://qa-wxtrust-jws.wancloud.io/porosity
mv porosity /usr/local/bin && chmod 0755 /usr/local/bin/porosity

RUN cd /
RUN git clone https://github.com/jpmorganchase/quorum-examples
