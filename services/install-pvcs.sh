#!/bin/bash

# Install a shared pvcs for the beamline - do this before any other services
helm upgrade --install shared-pvcs oci://ghcr.io/epics-containers/domain-shared-pvcs \
     --version 2.0.0 --set beamline=bl38p
