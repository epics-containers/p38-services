Beamline BL38P: a Test epics-containers Beamline
================================================

This repository contains the configuration files for the IOC instances
running within a domain at **Diamond Light Source**. This can be used as a
template project for other beamlines and accelerator domains.

This is a **Diamond Light Source** specific reference implementation of a beamline
for [epics-containers](https://github.com/epics-containers).


Setting up your environment to use BL38P
----------------------------------------

Inside DLS you can experiment with this beamline by setting up your environment
as follows:

1. Download the project's environment file using the curl command below.

   Note that this places files
   in your home directory under `~/.local/bin` and you may need to add this to
   your `PATH` environment variable, however, if you use the standard DLS profile
   this will be done for you next time you open a new shell.

   You will be asked for your cluster credentials which are the same as your
   linux login. Note that if you have not used this cluster before you may need
   to ask the cloud team for access. To do so
   [use this form](https://jira.diamond.ac.uk/servicedesk/customer/portal/2/create/92)
   and ask for access to namespace `p38-iocs` on cluster `k8s-p38`.


```bash
curl https://raw.githubusercontent.com/epics-containers/bl38p/main/environment.sh -o ~/.local/bin/bl38p

~/.local/bin/bl38p
```

2. Now if everything is working you should be able to see the IOC instances
   running on the kubernetes cluster as follows:

```bash
[hgv27681@pc0116 bl38p]$ ec ps
IOC_NAME          VERSION     STATE     RESTARTS   STARTED
bl38p-ea-ioc-03   2023.10.2   Running   0          2023-10-21T19:10:33Z
[hgv27681@pc0116 bl38p]$
```

3. You can also take a look at what other commands are available:

```bash
ec --help
ec ioc --help
ec dev --help
```

Using this Template to Create a New Beamline or Accelerator Domain
==================================================================

This is simply a matter of taking a copy of this repository and changing the
p38 and 38p references to the name of your domain. In the following example
we will create the repository for the beamline BL16I.

1. Create a new completely blank repository in gitlab

   - go to https://gitlab.diamond.ac.uk/controls/containers/beamline
   - click on the "New Project" button and choose Blank Project
   - give the project a name, e.g. `bl16i`
   - uncheck `create readme`
   - click on the "Create Project" button
   - copy the repo URI from the example in `Create a new repository`
   - now execute the following:

```bash
git clone git@github.com:epics-containers/bl38p.git -b 2023.10.2
mv bl38p bl16i
cd bl16i
sed -i -e s/ixx/i16/ -e s/xxi/16i/ $(find * -type f)
# the repo uri copied from above steps is pasted below
git remote set-url origin git@gitlab.diamond.ac.uk:controls/containers/beamline/bl16i.git
git push -u origin main
```