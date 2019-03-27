FROM lnlssol/docker-debian9-base3_14-synapps6

RUN apt-get update

RUN apt-get install -y libssh2-1-dev libboost-all-dev python3-sphinx doxygen python3-breathe

WORKDIR /tmp
RUN mkdir -p /usr/local/epics/apps/pmac

COPY fix-pmac-paths.sh /tmp

CMD bash
