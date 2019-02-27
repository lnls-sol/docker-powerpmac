FROM lnlssol/docker-debian9-base3_14-synapps6

RUN apt-get install -y libssh2-1-dev libboost-all-dev

WORKDIR /tmp
RUN mkdir -p /usr/local/epics/apps

COPY fix-pmac-paths.sh /tmp

CMD bash
