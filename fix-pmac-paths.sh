#!/bin/bash

#****************************************************************************************
# Fix pmac module stuff
sed -i 's:/asyn/4-34:/asyn-R4-33:g'        /usr/local/epics/apps/pmac/configure/RELEASE.local
sed -i 's:/calc/3-7:/calc-R3-7-1:g'        /usr/local/epics/apps/pmac/configure/RELEASE.local
sed -i 's:/motor/7-0dls1:/motor-R6-10-1:g' /usr/local/epics/apps/pmac/configure/RELEASE.local
sed -i 's:/busy/1-7dls1:/busy-R1-7:g'      /usr/local/epics/apps/pmac/configure/RELEASE.local

sed -i 's:/dls_sw/prod/R3.14.12.7/support:/usr/local/epics/synApps/support:g' /usr/local/epics/apps/pmac/configure/RELEASE.linux-x86_64.Common
sed -i 's:/dls_sw/work/R3.14.12.7/support:/usr/local/epics/synApps/support:g' /usr/local/epics/apps/pmac/configure/RELEASE.linux-x86_64.Common
sed -i 's:/dls_sw/epics/R3.14.12.7/base:/usr/local/epics/base:g'              /usr/local/epics/apps/pmac/configure/RELEASE.linux-x86_64.Common

sed -i 's:/dls_sw/prod/tools/RHEL6-x86_64/boost/1-48-0/prefix:/usr:g' /usr/local/epics/apps/pmac/configure/CONFIG_SITE.linux-x86_64.Common
sed -i 's:$(BOOST)/lib:$(BOOST)/lib/x86_64-linux-gnu:g'               /usr/local/epics/apps/pmac/configure/CONFIG_SITE.linux-x86_64.Common
sed -i 's:$(SSH)/lib64:$(SSH)/lib/x86_64-linux-gnu:g'                 /usr/local/epics/apps/pmac/configure/CONFIG_SITE.linux-x86_64.Common

#****************************************************************************************
# fix boost
find /usr/local/epics/apps/pmac -type f -exec sed -i 's/BOOST_MESSAGE/BOOST_TEST_MESSAGE/g' {} \;

#****************************************************************************************
# Fix container Pmac IOC to see local epics instead epics-nfs
# TODO Mimic the nfs file organization and remove this fix...

# RELEASE file
sed -i 's:/usr/local/epics-nfs/modules/R3.14.12.8/synApps/R6.0/support/:/usr/local/epics/synApps/support/:g' /usr/local/epics/apps/Pmac/configure/RELEASE
sed -i 's:/usr/local/epics-nfs/modules/R3.14.12.8/pmac/2-4-10/:/usr/local/epics/apps/pmac/:g'                /usr/local/epics/apps/Pmac/configure/RELEASE
sed -i 's:/usr/local/epics-nfs/base/R3.14.12.8:/usr/local/epics/base:g'                                      /usr/local/epics/apps/Pmac/configure/RELEASE

# pmac.substitutions file
sed -i 's:/usr/local/epics-nfs/apps/pmac/2019_05_14_01/db:/usr/local/epics/apps/pmac/db:g' /usr/local/epics/apps/Pmac/pmacApp/Db/pmac.substitutions

#****************************************************************************************
# Fix dls_pmac_asyn_motor.template and dls_pmac_cs_asyn_motor.template in order to recognize other necessary templates
sed -i 's:basic_asyn_motor\.template:/usr/local/epics/apps/pmac/db/basic_asyn_motor\.template:g'                       /usr/local/epics/apps/pmac/pmacApp/Db/dls_pmac_asyn_motor.template
sed -i 's:motor_in_cs\.template:/usr/local/epics/apps/pmac/db/motor_in_cs\.template:g'                                 /usr/local/epics/apps/pmac/pmacApp/Db/dls_pmac_asyn_motor.template
sed -i 's:eloss_kill_autohome_records\.template:/usr/local/epics/apps/pmac/db/eloss_kill_autohome_records\.template:g' /usr/local/epics/apps/pmac/pmacApp/Db/dls_pmac_asyn_motor.template
sed -i 's:pmacDirectMotor\.template:/usr/local/epics/apps/pmac/db/pmacDirectMotor\.template:g'                         /usr/local/epics/apps/pmac/pmacApp/Db/dls_pmac_asyn_motor.template

sed -i 's:basic_asyn_motor\.template:/usr/local/epics/apps/pmac/db/basic_asyn_motor\.template:g' /usr/local/epics/apps/pmac/pmacApp/Db/dls_pmac_cs_asyn_motor.template

#****************************************************************************************
# Comment out this annoying substitute
# QUESTION Why this substute is here and why it does not work?
sed -i 's:substitute:#substitute:g' /usr/local/epics/apps/pmac/pmacApp/Db/dls_pmac_asyn_motor.template

export EPICS_HOST_ARCH="linux-x86_64"
