Beamline BL38P the test epics-containers Beamline
=================================================

This repository contains the configuration files for the IOC instances
running on a beamline.

It is a reference implementation of a beamline for
[epics-containers](https://github.com/epics-containers).

Inside DLS you can experiment with this beamline by setting up your environment
as follows:

1. Set up a python virtual environment if you do not already have one.

```bash
module load python/3.10
python -m venv ~/.local/epics-containers
source ~/.local/epics-containers/bin/activate
```

2. Set up your environment for for this beamline

```bash
# get domain environment file
curl https://raw.githubusercontent.com/epics-containers/bl38p/main/environment.sh -o ~/.local/bin/bl38p

# set up the environment
~/.local/bl38p

# You will asked for kubernetes credentials which are same as your linux login.

# You may also need to ask the cloud team for access to the kubernetes namespace
# 38p-iocs on cluster bl38p
```

3. Now if everything is working you should be able to see the IOC instances
   running on the kubernetes cluster:

```bash
ec ps
```

4. And also take a look at what other commands are available:

```bash
ec --help
ec ioc --help
```

