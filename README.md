# Power PMAC module docker

This docker has the powerpmac module (https://github.com/dls-controls/pmac) fixed to run on lnls.

## Building the image

Run

```sh
git clone https://gitlab.cnpem.br/SOL/Docker/powerpmac.git
cd powerpmac
docker build -t powerpmac_ioc .
```

## Running container

If you want to create a development folder on host computer, as you could do for your customized IOC, map the host folder on `dev` folder, which was created for this purpose:

```sh
docker run -it --rm -v /path/to/your/dev/folder/:/home/dev powerpmac_ioc bash
```

## Running Diamond IOC simple-power-pmac:

* Edit /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/stlab.src , to use the right IP, changing this line:

`drvAsynPowerPMACPortConfigure("BRICK1port", "172.23.247.1", "root", "deltatau", "0", "0", "0")`

* Then execute:

`./stlab.sh`

# Further information

## Create your own IOC from scratch

If you want to build your customized IOC from scratch, follow the [presentation](https://cnpemcamp.sharepoint.com/:p:/r/sites/lnls/projects/blcsystems/_layouts/15/Doc.aspx?sourcedoc=%7BA72CCBB3-0897-407F-9E19-B8C148A49411%7D&file=Simple%20Coordinated%20Movement%20On%20PowerPMAC%20Using%20EPICS.pptx&action=edit&mobileredirect=true), which uses the [slit](https://gitlab.cnpem.br/SOL/EpicsApps/PmacSlits) setup for example.

## LNLS slit coordinated motion IOC

We have developed a simple coordinated motion using the simplest mecanism on our Lab: the slit. Check out our [repository](https://gitlab.cnpem.br/SOL/EpicsApps/PmacSlits)!

## PowerPMAC trajectory generation

We are integrating the codes from [Diamond Light Source](https://github.com/dls-controls/pmac/) on our setup. Check out our [repository](https://gitlab.cnpem.br/SOL/EpicsApps/PmacTrajectory)!
