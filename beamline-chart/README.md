Beamline or Accelerator Domain Helm Chart Template
==================================================

The files in this folder are used to generate a helm chart for IOC instances
on this repository's beamline or accelerator domain.

We generate a new helm chart for each IOC instance deployment. This is
primarily because helm cannot package the config folder at package time.
This approach could therefore be reviewed once this PR is released:
https://github.com/helm/helm/pull/10077

The other reasons for this approach are:

1. We prefer to have the entire definition of an IOC domain in a single repository.
   rather than pulling the chart from a chart repository.

To deploy at IOC using beamline chart make sure you have epics-containers-cli
installed and you are connected to the correct kubernetes cluster.

```bash
   source environment.sh
   ec ioc deploy <ioc_name> <ioc_version>
```

see: [EPICS Containers CLI Repository](https://github.com/epics-containers/epics-containers-cli).

