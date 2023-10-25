#!/bin/bash

# a bash script to source in order to set up your command line to interact with
# a specific beamline. This needs to be customized per beamline / domain

# check we are sourced
if [ "$0" = "$BASH_SOURCE" ]; then
    echo "ERROR: Please source this script"
    exit 1
fi

THIS_DIR=$(dirname ${BASH_SOURCE})

echo "Loading IOC environment for BL38P ..."

# a mapping between genenric IOC repo roots and the related container registry
export EC_REGISTRY_MAPPING='github.com=ghcr.io gitlab.diamond.ac.uk=gcr.io/diamond-privreg/controls/ioc'
# the namespace to use for kubernetes deployments
export EC_K8S_NAMESPACE=p38-iocs
# the git organisation used for beamline repositories
export EC_GIT_ORG=https://github.com/epics-containers
# the git repo for this beamline (or accelerator domain)
export EC_DOMAIN_REPO=git@github.com:epics-containers/bl38p.git
# declare your centralised log server Web UI
export EC_LOG_URL='https://graylog2.diamond.ac.uk/search?rangetype=relative&fields=message%2Csource&width=1489&highlightMessage=&relative=172800&q=pod_name%3A{ioc_name}*'
# enforce a specific container cli - defaults to which is available
# export EC_CONTAINER_CLI=podman
# enable debug output in all 'ec' commands leave blan
# export EC_DEBUG=1

#  use the ec version from dls_sw/work/python3
mkdir -p $HOME/.local/bin
ln -fs /dls_sw/work/python3/ec-venv/bin/ec $HOME/.local/bin/ec

 # TODO - in future all of this file will get absorbed into
 # module load k8s-p38

# the following configures kubernetes inside DLS if the module is available
if [[ $(module avail k8s-p38 2>&1) == *"k8s"* ]] ; then
    module unload k8s-p38 2> /dev/null
    module load k8s-p38
    # set the default namespace for kubectl and helm (for convenience only)
    kubectl config set-context --current --namespace=p38-iocs
    # get running iocs: makes sure the user has provided credentials
    /dls_sw/work/python3/ec-venv/bin/ec ps
fi

# enable completion for all relevant commands
shell=$(basename $SHELL)
source <(/dls_sw/work/python3/ec-venv/bin/ec --show-completion ${shell})
source <(kubectl completion ${shell})
source <(helm completion ${shell})
# alias kubectl to k with completion
alias k=kubectl
complete -F __start_kubectl k


