# Power PMAC IOC example

This docker compile power pmac example from pmac ioc (https://github.com/dls-controls/pmac)

## To run docker

docker container run -it --rm -v path_to_pmac:/usr/local/epics/apps/pmac --net=host ppmac bash

## To run IOC

* Execute /tmp/fix-pmac-paths.sh script

`./fix-pmac-paths.sh` 

* Edit /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/stlab.src , to use the right IP, changing this line:

`drvAsynPowerPMACPortConfigure("BRICK1port", "172.23.247.1", "root", "deltatau", "0", "0", "0")`

* Then execute (on the same path as stlab.src):

`./stlab.sh`
