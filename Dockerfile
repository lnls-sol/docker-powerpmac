FROM lnlssol/docker-debian9-base3_14-synapps6


RUN apt-get install -y libssh2-1-dev libboost-all-dev

WORKDIR /tmp
RUN git clone https://github.com/dls-controls/pmac
WORKDIR /tmp/pmac
RUN git checkout ppmac-example
RUN mkdir /usr/local/epics/apps
RUN mv /tmp/pmac /usr/local/epics/apps

COPY fix-pmac-paths.sh /tmp
RUN /tmp/fix-pmac-paths.sh

WORKDIR /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/

CMD bash
