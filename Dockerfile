FROM lnlssol/docker-debian9-base3_14-synapps6

################################################################################################
# Update and install necessary packages to run pmac module and to generate documentation
################################################################################################
RUN apt-get upgrade
RUN apt-get update
RUN apt-get install -y libssh2-1-dev libboost-all-dev python3-sphinx doxygen python3-breathe

################################################################################################
# Install python packages in order to perform George's tests with trajectory.
################################################################################################
# We will see if this tests become final product.
RUN apt-get install -y python3-pip
RUN pip3 install numpy pyepics

################################################################################################
# Create a folder to put pmac stuff
################################################################################################
RUN mkdir -p /usr/local/epics/apps/
WORKDIR /usr/local/epics/apps/
# TODO We haven't merged with master yet!
RUN git clone https://github.com/dls-controls/pmac.git
# TODO Clone powerpmac ioc (In future pmacslit name will be change to something else that pass more generic idea about this ioc)
# TODO We haven't merged with master yet!
RUN git clone -b dev https://gitlab.cnpem.br/SOL/EpicsApps/PmacSlits.git

################################################################################################
# Fix pmac repository paths in order to run on lnls
################################################################################################
# This snippet has been commented because now we are clonning from our fork of pmac module
WORKDIR /tmp
COPY fix-pmac-paths.sh /tmp
RUN ./fix-pmac-paths.sh

################################################################################################
# Compile pmac module
################################################################################################
#WORKDIR /usr/local/epics/apps/pmac/
#ARG EPICS_HOST_ARCH="linux-x86_64"
#RUN make

################################################################################################
# Compile powerpmac ioc
################################################################################################
WORKDIR /usr/local/epics/apps/PmacSlits
ENV PATH="/usr/local/epics/extensions/bin/linux-x86_64/:${PATH}"
RUN make

################################################################################################
# Set startup directory as the ioc boot
################################################################################################
WORKDIR /usr/local/epics/apps/PmacSlits/iocBoot/iocslit

################################################################################################
# Set default program on docker run
################################################################################################
CMD bash
