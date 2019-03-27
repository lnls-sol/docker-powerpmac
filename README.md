# Power PMAC IOC example

This docker compile power pmac example from pmac ioc (https://github.com/dls-controls/pmac)

## Fixing module and example IOC paths

* Run fix script when your docker start (The initial path will be /tmp/):

`./fix-pmac-paths.sh`

**NOTE:** This script will compile PPMAC module and simple-power-pmac IOC. 

## To run Diamond IOC simple-power-pmac:

* Edit /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/stlab.src , to use the right IP, changing this line:

`drvAsynPowerPMACPortConfigure("BRICK1port", "172.23.247.1", "root", "deltatau", "0", "0", "0")`

* Then execute:

`./stlab.sh`
