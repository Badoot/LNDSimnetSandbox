FROM ubuntu
LABEL Lightning Network Daemon Simnet Sandbox
RUN apt-get update -y
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/gocode/bin
RUN apt-get install wget git build-essential gcc make -y
RUN wget https://dl.google.com/go/go1.12.4.linux-amd64.tar.gz
RUN tar zxvf ./go1.12.4.linux-amd64.tar.gz -C /usr/local
ENV GOPATH=/gocode
ENV GOROOT=/usr/local/go
RUN go get -d github.com/lightningnetwork/lnd
RUN cd /gocode/src/github.com/lightningnetwork/lnd && make && make install && make btcd
RUN echo "alias btcctl='btcctl --rpcuser=testuser --rpcpass=testpass --simnet'" >> ~/.bashrc
RUN echo "alias lncli-alice='lncli --rpcserver=localhost:10001 \
 --no-macaroons --tlscertpath=/gocode/dev/alice/data/tls.cert'" >> ~/.bashrc 
RUN echo "alias lncli-bob='lncli --rpcserver=localhost:10002 \
 --no-macaroons --tlscertpath=/gocode/dev/bob/data/tls.cert'" >> ~/.bashrc 
RUN echo "alias lncli-charlie='lncli --rpcserver=localhost:10003 \
 --no-macaroons --tlscertpath=/gocode/dev/charlie/data/tls.cert'" >> ~/.bashrc 
RUN echo "alias lncli-danny='lncli --rpcserver=localhost:10004 \
 --no-macaroons --tlscertpath=/gocode/dev/danny/data/tls.cert'" >> ~/.bashrc 
EXPOSE 10001-10004/tcp
RUN rm /*gz
COPY lndsetup.sh /
CMD /lndsetup.sh && bash 
