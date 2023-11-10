#!/bin/bash

# Install a nginx server to publish GUI files for the beamline
# helm upgrade --install opis oci://ghcr.io/epics-containers/domain-opis \
#      --version 1.1.0 --set beamline=bl38p

helm upgrade --install opis /repos/ec-helm-charts/Charts/opis \
     --version 1.1.1 --set beamline=bl38p