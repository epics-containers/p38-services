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

1. For convenience you will need `~/.local/bin` in your path. To do this
   edit the file `~/.bash_profile` and add the following line at the end:

   ```bash
   export PATH="$PATH:~/.local/bin"
   ```

1. Download and apply the project's environment file using the commands below.

   ```bash
   cd /tmp
   curl -o ~/.local/bin/bl38p https://raw.githubusercontent.com/epics-containers/bl38p/main/environment.sh?token=$(date +%s)
   . ~/.bash_profile # adds ~/.local/bin to path
   . bl38p
   ```

   You will be asked for your cluster credentials which are the same as your
   linux login. Note that if you have not used this cluster before you may need
   to ask the cloud team for access. To do so
   [use this form](https://jira.diamond.ac.uk/servicedesk/customer/portal/2/create/92)
   and ask for access to namespace `p38-iocs` on cluster `k8s-p38`.

   After logging out and back in again to pick up your profile changes you can
   then reload the bl38p environment with the following command:

   ```bash
   . bl38p
   ```

1. Now if everything is working you should be able to see the IOC instances
   running on the kubernetes cluster as follows:

   ```bash
   $ ec ps
   IOC_NAME          VERSION     STATE     RESTARTS   STARTED
   bl38p-ea-ioc-03   2023.10.2   Running   0          2023-10-21T19:10:33Z
   ```

1. You can also take a look at what other commands are available:

   ```bash
   ec --help
   ec ioc --help
   ec dev --help
   ```


1. To see the underlying commands that `ec` is using add the `-v` flag:

   <pre><font color="#26A269">(dev) </font>[<font color="#12488B">hgv27681@pc0116</font> bl38p]$ ec -v ps
   <font color="#5F8787">kubectl get namespace p38-iocs -o name</font>
   <font color="#5F8787">kubectl -n p38-iocs get pod -l is_ioc==True -o custom-columns=IOC_NAME:metadata.labels.app,VERSION:metadata.labels.ioc_version,STATE:status.phase,RESTARTS:status.containerStatuses[0].restartCount,STARTED:metadata.managedFields[0].time</font>
   IOC_NAME            VERSION             STATE     RESTARTS   STARTED
   bl38p-ea-ioc-03     2023.10.27-b6.24    Running   0          2023-10-30T15:21:55Z
   bl38p-ea-panda-02   2023.10.25-b16.24   Running   0          2023-10-30T15:25:54Z
   </pre>


1. For a visual interface to the ioc namespace on the cluster you can use the
   kubernetes dashboard at this URL:

   https://k8s-p38-dashboard.diamond.ac.uk/#/pod?namespace=p38-iocs


How to Create a New Beamline / Accelerator Domain
=================================================

NOTE: These instructions are DLS specific. Please see
[epics-containers docs](https://epics-containers.github.io/main/user/tutorials/create_beamline.html)
for more general instructions.

The p38 beamline is a reference implementation of a DLS beamline so we use it
as a template for other beamlines and accelerator domains.

To create a new domain take a copy of this repository and change the
p38 and 38p references to the name of your domain. In the following example
we will create the repository for the beamline BL16I.

1. Clone this template repository and replace its remote with the new
   repository using the command sequence below. (example is for i16 - replace
   i16 with your beamline name)

   ```bash
   git clone git@github.com:epics-containers/bl38p.git
   mv bl38p bl16i
   cd bl16i

   # this will create a new repo for you in gitlab - CHECK FOR TYPOS
   git remote set-url origin git@gitlab.diamond.ac.uk:controls/containers/beamline/bl16i.git
   ```

2. Edit the contents to match your new beamline / accelerator domain name.
   as follows (example is for i16 - replace i16 with your beamline name):

   ```bash
   # use sed to replace all occurrences of p38 with i16 (in all its various forms)
   sed -i -e s/p38/i16/g -e s/38p/16i/g -e s/38P/16I/g $(find * -type f)

   # manually edit 'environment.sh' setting EC_DOMAIN_REPO to the new repo name
   # you supplied in step 1.

   # manually edit 'README.md' as needed. Remove this section
   # 'How to Create a New Beamline or Accelerator Domain'

   # commit your changes to the new gitlab repo
   git commit -am'switch to i16'
   git push -u origin main
   ```

2. Implement your own IOC instances for the new domain by adding subfolders
   to /iocs. There will be example IOCs from the beamline you copied already in
   here, you could choose to delete these or use them as a starting point for
   your own IOCs.

   Each IOC subfolder should contain the following:

   - `values.yaml` - this is the helm chart values file for the IOC instance.
     At a minimum it should contain the URI of the generic IOC container image
     to use. For example to use the current latest GigE camera Generic IOC
     put the following in the values.yaml file:

     ```yaml
     image: ghcr.io/epics-containers/ioc-adaravis-linux-runtime:2023.11.1b5
     ```

     This yaml file may also override any of the settings in the beamline
     helm chart's values file. See
     [Beamline values.yaml](beamline-chart/values.yaml)
     for the full list of settings that can be overridden.

     For an example of a GigE camera IOC instance for this beamline see:
     [IOC values.yaml](iocs/bl38p-di-dcam-01/values.yaml).

   - `config` - this folder will be mounted into the Generic IOC at runtime at
     `/epics/ioc/config`. This folder will contain the required files to make
      the generic IOC into a specific IOC instance.

      The 1st choice for the config folder should be an ibek IOC YAML file
      For an example `config.yaml` for a GigE camera IOC see:
      [config.yaml](iocs/bl38p-di-dcam-01/config/ioc.yaml).


      For the details of all the options for what can go in the config folder see:
      [start.sh](https://github.com/epics-containers/blxxi-template/blob/main/iocs/blxxi-ea-ioc-01/config/start.sh)
