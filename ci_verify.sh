#!/bin/bash

# CI to verify all the IOC instances specified in this repo
# Domain agnostic - this script is generic for all beamlines/domains

THIS_DIR=$(dirname ${0})
set -e

for ioc in ${THIS_DIR}/iocs/*
do
    # Skip if subfolder is not an IOC definition
    if [ ! -d "${ioc}/config" ]; then
        continue
    fi

    ec ioc validate "${ioc}"
done

