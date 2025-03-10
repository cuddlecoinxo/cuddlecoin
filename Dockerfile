# daemon runs in the background
# run something like tail /var/log/CuddleCoind/current to see the status
# be sure to run with volumes, ie:
# docker run -v $(pwd)/CuddleCoind:/var/lib/CuddleCoind -v $(pwd)/wallet:/home/cuddlecoin --rm -ti cuddlecoin:0.2.2
ARG base_image_version=0.10.0
FROM phusion/baseimage:$base_image_version

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

ADD https://github.com/just-containers/socklog-overlay/releases/download/v2.1.0-0/socklog-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/socklog-overlay-amd64.tar.gz -C /

ARG CUDDLECOIN_BRANCH=development
ENV CUDDLECOIN_BRANCH=${CUDDLECOIN_BRANCH}

# install build dependencies
# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      python-dev \
      gcc-4.9 \
      g++-4.9 \
      git cmake \
      libboost1.58-all-dev && \
    git clone https://github.com/cuddlecoinxo/cuddlecoin.git /src/cuddlecoin && \
    cd /src/cuddlecoin && \
    git checkout $CUDDLECOIN_BRANCH && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_FLAGS="-g0 -Os -fPIC -std=gnu++11" .. && \
    make -j$(nproc) && \
    mkdir -p /usr/local/bin && \
    cp src/CuddleCoind /usr/local/bin/CuddleCoind && \
    cp src/walletd /usr/local/bin/walletd && \
    cp src/zedwallet /usr/local/bin/zedwallet && \
    cp src/miner /usr/local/bin/miner && \
    strip /usr/local/bin/CuddleCoind && \
    strip /usr/local/bin/walletd && \
    strip /usr/local/bin/zedwallet && \
    strip /usr/local/bin/miner && \
    cd / && \
    rm -rf /src/cuddlecoin && \
    apt-get remove -y build-essential python-dev gcc-4.9 g++-4.9 git cmake libboost1.58-all-dev && \
    apt-get autoremove -y && \
    apt-get install -y  \
      libboost-system1.58.0 \
      libboost-filesystem1.58.0 \
      libboost-thread1.58.0 \
      libboost-date-time1.58.0 \
      libboost-chrono1.58.0 \
      libboost-regex1.58.0 \
      libboost-serialization1.58.0 \
      libboost-program-options1.58.0 \
      libicu55

# setup the CuddleCoind service
RUN useradd -r -s /usr/sbin/nologin -m -d /var/lib/CuddleCoind CuddleCoind && \
    useradd -s /bin/bash -m -d /home/cuddlecoin cuddlecoin && \
    mkdir -p /etc/services.d/CuddleCoind/log && \
    mkdir -p /var/log/CuddleCoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/CuddleCoind/run && \
    echo "fdmove -c 2 1" >> /etc/services.d/CuddleCoind/run && \
    echo "cd /var/lib/CuddleCoind" >> /etc/services.d/CuddleCoind/run && \
    echo "export HOME /var/lib/CuddleCoind" >> /etc/services.d/CuddleCoind/run && \
    echo "s6-setuidgid CuddleCoind /usr/local/bin/CuddleCoind" >> /etc/services.d/CuddleCoind/run && \
    chmod +x /etc/services.d/CuddleCoind/run && \
    chown nobody:nogroup /var/log/CuddleCoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/CuddleCoind/log/run && \
    echo "s6-setuidgid nobody" >> /etc/services.d/CuddleCoind/log/run && \
    echo "s6-log -bp -- n20 s1000000 /var/log/CuddleCoind" >> /etc/services.d/CuddleCoind/log/run && \
    chmod +x /etc/services.d/CuddleCoind/log/run && \
    echo "/var/lib/CuddleCoind true CuddleCoind 0644 0755" > /etc/fix-attrs.d/CuddleCoind-home && \
    echo "/home/cuddlecoin true cuddlecoin 0644 0755" > /etc/fix-attrs.d/cuddlecoin-home && \
    echo "/var/log/CuddleCoind true nobody 0644 0755" > /etc/fix-attrs.d/CuddleCoind-logs

VOLUME ["/var/lib/CuddleCoind", "/home/cuddlecoin","/var/log/CuddleCoind"]

ENTRYPOINT ["/init"]
CMD ["/usr/bin/execlineb", "-P", "-c", "emptyenv cd /home/cuddlecoin export HOME /home/cuddlecoin s6-setuidgid cuddlecoin /bin/bash"]
