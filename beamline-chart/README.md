Beamline or Accelerator Domain Helm Chart Template
==================================================

The files in this folder are used to generate a helm chart for IOC instances
on this repository's beamline or accelerator domain.

We generate a new helm chart for each IOC instance deployment. This is
primarily because helm cannot package the config folder at install time.
This approach could therefore be reviewed once this PR is released:
https://github.com/helm/helm/pull/10077

There are two other reasons for this approach:

1. We prefer to have the entire definition of a beamline or accelerator
  domain in a single repository.
1. We prefer to set the Chart version (as well as appVersion) as this is the
  primary version that is shown in K8S the dashboard.
  (this can be changed at package time so does
  not strictly need to set be in this template)

To deploy at IOC using beamline chart:

1. Clone a tagged version of this repo to ensure you have a known version
   of the chart template and matching IOC instance config.
1. Render the Chart.yaml.jinja template to create a Chart.yaml file
1. add the config folder from the ioc instance (from ../iocs) to this folder
1. package the chart using `helm package`
1. install the chart using `helm upgrade --install` passing the image name e.g.
   `--set image=ghcr.io/epics-containers/ioc-adaravis-linux-runtime:2023.10.4`

You may also use --set to override any of the values in the values.yaml file.

Note that the epics-containers-cli tool `ec` performs all of the above
steps on a tagged version of the ioc instance with the following command:
```bash
   ec ioc deploy <ioc_name> <ioc_version>
```
see: [EPICS Containers CLI Repository](https://github.com/epics-containers/epics-containers-cli).

