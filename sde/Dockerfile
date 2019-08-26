FROM ubuntu:latest
RUN apt-get update -y && apt-get install vim build-essential git openssl-dev autoconf automake curl build-essential libtool make pkg-config unzip \
	libhiredis-dev zlib1g-dev libssl-dev libsasl2-dev libzstd-dev libboost-all-dev # Install
RUN git clone https://github.com/mattpaletta/scripts.git && cd scripts && bash build.sh && \
    bash install.sh -a
