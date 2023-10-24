#!/bin/bash

# Create the OPI directory
mkdir -p /epics/opi
# Start the Panda soft IOC application
pandablocks-ioc softioc bl38p-mo-panda-01 BL38P-EA-PANDA-01 --clear-bobfiles --screens-dir /epics/opis

