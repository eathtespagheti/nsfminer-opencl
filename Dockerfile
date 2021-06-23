FROM debian:sid as build
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y build-essential git cmake mesa-common-dev libdbus-1-dev
ARG VERSION=master
RUN git clone https://github.com/no-fee-ethereum-mining/nsfminer.git /nsfminer
RUN git -C /nsfminer checkout $VERSION
RUN git -C /nsfminer submodule update --init --recursive
RUN mkdir -p /nsfminer/build
WORKDIR /nsfminer/build
RUN cmake .. -DETHASHCUDA=OFF
RUN cmake --build .
RUN make install

FROM frolvlad/alpine-glibc
COPY --from=build /usr/local/bin/nsfminer /usr/bin/nsfminer
WORKDIR /
COPY start_miner.sh /start_miner.sh
ENV LC_ALL=C
ENV LD_LIBRARY_PATH=/lib:/usr/local/lib:/usr/lib:/usr/externalibs
CMD ["/start_miner.sh"]