#!/bin/bash

sed -i 's:/asyn/4-34:/asyn-R4-33:g' /usr/local/epics/apps/pmac/configure/RELEASE.local
sed -i 's:/calc/3-7:/calc-R3-7-1:g' /usr/local/epics/apps/pmac/configure/RELEASE.local
sed -i 's:/motor/6-10-1dls1-1:/motor-R6-10-1:g' /usr/local/epics/apps/pmac/configure/RELEASE.local
sed -i 's:/busy/1-7dls1:/busy-R1-7:g' /usr/local/epics/apps/pmac/configure/RELEASE.local

sed -i 's:/dls_sw/prod/R3.14.12.7/support:/usr/local/epics/synApps/support:g' /usr/local/epics/apps/pmac/configure/RELEASE.linux-x86_64.Common
sed -i 's:/dls_sw/work/R3.14.12.7/support:/usr/local/epics/synApps/support:g' /usr/local/epics/apps/pmac/configure/RELEASE.linux-x86_64.Common
sed -i 's:/dls_sw/epics/R3.14.12.7/base:/usr/local/epics/base:g' /usr/local/epics/apps/pmac/configure/RELEASE.linux-x86_64.Common


sed -i 's:/dls_sw/prod/tools/RHEL6-x86_64/boost/1-48-0/prefix:/usr:g' /usr/local/epics/apps/pmac/configure/CONFIG_SITE.linux-x86_64.Common
sed -i 's:$(BOOST)/lib:$(BOOST)/lib/x86_64-linux-gnu:g' /usr/local/epics/apps/pmac/configure/CONFIG_SITE.linux-x86_64.Common
sed -i 's:$(SSH)/lib64:$(SSH)/lib/x86_64-linux-gnu:g' /usr/local/epics/apps/pmac/configure/CONFIG_SITE.linux-x86_64.Common

# fix boost
find /usr/local/epics/apps/pmac -type f -exec sed -i 's/BOOST_MESSAGE/BOOST_TEST_MESSAGE/g' {} \;


sed -i 's:/dls_sw/prod/R3.14.12.7/support:/usr/local/epics/synApps/support:g' /usr/local/epics/apps/pmac/iocs/simple-power-pmac/configure/RELEASE
sed -i 's:/asyn/4-33:/asyn-R4-33:g'  /usr/local/epics/apps/pmac/iocs/simple-power-pmac/configure/RELEASE
sed -i 's:/calc/3-7:/calc-R3-7-1:g'  /usr/local/epics/apps/pmac/iocs/simple-power-pmac/configure/RELEASE
sed -i 's:/home/hgv27681/R3.14.12.7/support/motor:$(SUPPORT)/motor-R6-10-1:g' /usr/local/epics/apps/pmac/iocs/simple-power-pmac/configure/RELEASE
sed -i 's:/busy/1-7:/busy-R1-7:g'  /usr/local/epics/apps/pmac/iocs/simple-power-pmac/configure/RELEASE
sed -i 's:/home/hgv27681/R3.14.12.7/support/pmac:/usr/local/epics/apps/pmac:g'  /usr/local/epics/apps/pmac/iocs/simple-power-pmac/configure/RELEASE
sed -i 's:/dls_sw/epics/R3.14.12.7/base:/usr/local/epics/base:g'   /usr/local/epics/apps/pmac/iocs/simple-power-pmac/configure/RELEASE

export EPICS_HOST_ARCH="linux-x86_64"

cd /usr/local/epics/apps/pmac
make

################################
# Old ioc (We use PmacSlits now)
################################
##ignoring stlab.boot
#sed -i 's:SCRIPTS += stlab.boot:#SCRIPTS += stlab.boot:g'   /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/Makefile
#
#sed -i 's:exec ./lab stlab.boot:export INSTALL=/usr/local/epics/apps/pmac/iocs/simple-power-pmac\nexec ../../bin/linux-x86_64/lab stlab.src:g' /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/stlab.sh
#chmod +x /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/stlab.sh
#
#cd /usr/local/epics/apps/pmac/iocs/simple-power-pmac
#export PATH=$PATH:/usr/local/epics/extensions/bin/linux-x86_64
#make
