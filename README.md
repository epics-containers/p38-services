Beamline BL38P: a Test epics-containers Beamline
================================================

This repository contains a specification of the IOC instances
running within a domain at **Diamond Light Source**.

This is a **Diamond Light Source** specific reference
implementation of a beamline for
[epics-containers](https://github.com/epics-containers).


Setting up your environment to use BL38P
----------------------------------------

Inside DLS you can access this beamline by setting up your environment
as follows:

1. Download the project's environment file using the curl command below.

   You will be asked for your cluster credentials which are the same as your
   linux login. Note that if you have not used this cluster before you may need
   to ask the cloud team for access. To do so
   [use this form](https://jira.diamond.ac.uk/servicedesk/customer/portal/2/create/92)
   and ask for access to namespace `p38-iocs` on cluster `k8s-p38`.


```bash
cd tmp
curl -O https://raw.githubusercontent.com/epics-containers/bl38p/main/environment.sh
. environment.sh
```
   Note that this places files
   in your home directory under `~/.local/bin` and you may need to add this to
   your `PATH` environment variable, however, if you use the standard DLS profile
   this will be done for you next time you open a new shell.

   After the first invocation (and starting a new shell to add  `~/.local/bin` to
   your path you can re-load the environment with this command:

```bash
. bl38p
```

2. Now if everything is working you should be able to see the IOC instances
   running on the kubernetes cluster as follows:

```bash
$ ec ps
IOC_NAME          VERSION     STATE     RESTARTS   STARTED
bl38p-ea-ioc-03   2023.10.2   Running   0          2023-10-21T19:10:33Z
```

3. You can also take a look at what other commands are available:

```bash
ec --help
ec ioc --help
ec dev --help
```

4. For a visual interface to the ioc namespace on the cluster you can use the
   kubernetes dashboard at this URL:

   https://k8s-p38-dashboard.diamond.ac.uk/#/pod?namespace=p38-iocs


How to Create a New Beamline or Accelerator Domain
==================================================

The p38 beamline is a reference implementation of a DLS beamline so we use it
as a template for other beamlines and accelerator domains.

To create a new domain take a copy of this repository and change the
p38 and 38p references to the name of your domain. In the following example
we will create the repository for the beamline BL16I.

1. Create a new completely blank repository in gitlab

   - go to https://gitlab.diamond.ac.uk/controls/containers/beamline
   - click on the "New Project" button and choose Blank Project
   - give the project a name, e.g. `bl16i`
   - uncheck `create readme`
   - click on the "Create Project" button
   - copy the repo URI from the example in `Create a new repository`

2. Clone this template repository and replace its remote with the new
   repository using the command sequence below.

```bash
git clone git@github.com:epics-containers/bl38p.git -b 2023.10.3
mv bl38p bl16i
cd bl16i
sed -i -e s/p38/i16/g -e s/38p/16i/g -e s/38P/16I/g $(find * -type f)
git checkout -b main
git commit -am'switch to i16'
# the repo uri copied from above steps is pasted below
git remote set-url origin git@gitlab.diamond.ac.uk:controls/containers/beamline/bl16i.git
git push -u origin main
```

3. Implement your own IOC instances for the new domain by adding subfolders
   to /iocs. There will be example IOCs from the beamline you copied already in
   here, you could choose to delete these or use them as a starting point for
   your own IOCs.

   Each IOC subfolder should contain the following:

   - `values.yaml` - this is the helm chart values file for the IOC instance.
     At a minimum it should contain the URI of the generic IOC container image
     to use e.g.:

     ```yaml
     image: ghcr.io/epics-containers/ioc-adsimdetector-linux-runtime:23.10.1
     ```

     This yaml file may also override any of the settings in the beamline
     helm chart's values file. See [values.yaml](beamline-chart/values.yaml)
     for the full list of settings that can be overridden.

   - `config` - this folder will be mounted into the Generic IOC at runtime at
     `/epics/ioc/config`. This folder will contain the required files to make
      the generic IOC into a specific IOC instance.

      For the details of the contents of the config folder see the default
      [start.sh](https://github.com/epics-containers/blxxi-template/blob/main/iocs/blxxi-ea-ioc-01/config/start.sh)
