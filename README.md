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

* Edit /usr/local/epics/apps/pmac/iocs/simple-power-pmac/labApp/Db/lab_expanded.substitutions to properly configure the motors.

    * The main fields are:
        * `SREV`:   Number of controller counts (open loop) or encoder counts (closed loop) per turn of the motor
        * `UREV`:   Number of units in EGU which the motor moves per turn. For closed loop, `UREV` = SREV×(Encoder Resolution)
        * `MRES`:   UREV÷SREV
        * `VMAX`:   Max motor speed in EGU
        * `HLM`:    Software positive limit switch in EGU. 0 in this field means 'software limit switch disabled'
        * `LLM`:    Software negative limit switch in EGU. 0 in this field means 'software limit switch disabled'

```shell
'
The example below setup a stepper motor in closed loop which has:
 SREV = 400 encoder counts per motor revolution
 UREV = 400×(Encoder Resolution) = 400*50 [nm] = 0.02 [mm]
 MRES = UREV÷SREV = 0.00005
 VMAX = 0.1 [mm/s]
 HLM = 0
 LLM = 0
'
# ...
file $(PMAC)/db/dls_pmac_asyn_motor.template
{
pattern {P, M, PORT, ADDR, DESC, MRES, VELO, PREC, EGU, TWV, DTYP, DIR, VBAS, VMAX, ACCL, BDST, BVEL, BACC, DHLM, DLLM, HLM, LLM, HLSV, INIT, SREV, RRES, ERES, JAR, UEIP, URIP, RDBL, RLNK, RTRY, DLY, OFF, RDBD, FOFF, ADEL, NTM, FEHIGH, FEHIHI, FEHHSV, FEHSV, SCALE, HOMEVIS, HOMEVISSTR, name, alh, gda_name, gda_desc, SPORT, HOME, PMAC, ALLOW_HOMED_SET }
    {"CAT:PPMAC004", ":MOTOR4", "Brick", "4", "Motor 4 - Microscope Y", "0.00005", "0.1", "5", "mm", "0.01", "asynMotor", "0", "0", "0.2", "0.5", "0", "0", "", "0", "0", "", "", "MAJOR", "", "400", "", "", "", "0", "0", "", "", "0", "0", "0", "", "0", "0", "1", "0", "0", "NO_ALARM", "NO_ALARM", "1", "1", "Use motor summary screen", "M4", "None", "", "$(DESC)", "BRICK1port", "$(P)", "BRICK1", "#"
    }
# ...
```
* After changing the substitutions, recompile the IOC:  
`cd /usr/local/epics/apps/pmac/iocs/simple-power-pmac/`  
`make clean uninstall install`

* Then execute:

`cd /usr/local/epics/apps/pmac/iocs/simple-power-pmac/iocBoot/ioclab/`  
`/.stlab.sh`

# Further information

## Create your own IOC from scratch

If you want to build your customized IOC from scratch, follow the [presentation](https://cnpemcamp.sharepoint.com/:p:/r/sites/lnls/projects/blcsystems/_layouts/15/Doc.aspx?sourcedoc=%7BA72CCBB3-0897-407F-9E19-B8C148A49411%7D&file=Simple%20Coordinated%20Movement%20On%20PowerPMAC%20Using%20EPICS.pptx&action=edit&mobileredirect=true), which uses the [slit](https://gitlab.cnpem.br/SOL/EpicsApps/PmacSlits) setup for example.

## LNLS slit coordinated motion IOC

We have developed a simple coordinated motion using the simplest mecanism on our Lab: the slit. Check out our [repository](https://gitlab.cnpem.br/SOL/EpicsApps/PmacSlits)!

## PowerPMAC trajectory generation

We are integrating the codes from [Diamond Light Source](https://github.com/dls-controls/pmac/) on our setup. Check out our [repository](https://gitlab.cnpem.br/SOL/EpicsApps/PmacTrajectory)!
