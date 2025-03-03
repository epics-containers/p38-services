#!/bin/bash
mkdir -p /epics/opi

pandablocks-ioc softioc bl38p-mo-panda-05 BL38P-EA-PANDA-05 --clear-bobfiles --screens-dir /epics/opi


