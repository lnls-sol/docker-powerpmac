FROM lnlssol/docker-debian9-base3_14-synapps6

# Update and install necessary packages to run pmac module and to generate documentation
RUN apt-get update
RUN apt-get install -y libssh2-1-dev libboost-all-dev python3-sphinx doxygen python3-breathe

# Install python packages in order to perform George's tests with trajectory.
# We will see if this tests become final product.
RUN apt-get install -y python3-pip
RUN pip3 install numpy pyepics

# Create a folder to put pmac stuff
RUN mkdir -p /usr/local/epics/apps/
WORKDIR /usr/local/epics/apps/
RUN git clone https://github.com/dls-controls/pmac

# Fix pmac repository paths in order to run on lnls
WORKDIR /tmp
COPY fix-pmac-paths.sh /tmp
RUN ./fix-pmac-paths.sh

# Start on a generic development folder
WORKDIR /home/dev
