FROM lnlssol/docker-debian9-base3_14-synapps6

################################################################################################
# Update and install necessary packages to run pmac module and to generate documentation
RUN apt-get upgrade
RUN apt-get update
RUN apt-get install -y libssh2-1-dev libboost-all-dev python3-sphinx doxygen python3-breathe

################################################################################################
# Install python packages in order to perform George's tests with trajectory.
# We will see if this tests become final product.
RUN apt-get install -y python3-pip
RUN pip3 install numpy pyepics

################################################################################################
# Create a folder to put pmac stuff
RUN mkdir -p /usr/local/epics/apps/
WORKDIR /usr/local/epics/apps/

################################################################################################
# Get pmac module
RUN wget https://github.com/dls-controls/pmac/archive/2-4-10.tar.gz
RUN tar -xvf 2-4-10.tar.gz
RUN mkdir pmac && tar xf 2-4-10.tar.gz -C pmac --strip-components 1
RUN rm -r 2-4-10.tar.gz

################################################################################################
# Get our IOC from repo
RUN git clone https://gitlab.cnpem.br/SOL/EpicsApps/Pmac.git

################################################################################################
# Fix pmac repository paths in order to run on lnls
# This snippet has been commented because now we are clonning from our fork of pmac module
WORKDIR /tmp
COPY fix-pmac-paths.sh /tmp
RUN ./fix-pmac-paths.sh

################################################################################################
# Compile pmac module
WORKDIR /usr/local/epics/apps/pmac/
ARG EPICS_HOST_ARCH="linux-x86_64"
RUN make

################################################################################################
# Copy motor template to right path
RUN cp /usr/local/epics/apps/Pmac/pmacApp/Db/basic_asyn_motor.template /usr/local/epics/apps/pmac/db

################################################################################################
# Compile Pmac ioc
WORKDIR /usr/local/epics/apps/Pmac
ENV PATH="/usr/local/epics/extensions/bin/linux-x86_64/:${PATH}"
RUN make

################################################################################################
# Create config structure identical to nfs
# FIXME When nfs structed is once here, this should be a bit different
RUN mkdir -p /usr/local/epics/apps/config/Pmac/
RUN cp /usr/local/epics/apps/Pmac/pmacApp/Db/pmac.substitutions /usr/local/epics/apps/config/Pmac/
RUN cp /usr/local/epics/apps/Pmac/iocBoot/iocpmac/st.cmd /usr/local/epics/apps/config/Pmac.cmd

################################################################################################
# Set startup directory as the ioc boot
WORKDIR /usr/local/epics/apps/config

################################################################################################
# Set default program on docker run
CMD bash
