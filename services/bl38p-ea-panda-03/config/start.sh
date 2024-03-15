#!/bin/bash
mkdir -p /epics/opi

pandablocks-ioc softioc bl38p-mo-panda-03 BL38P-EA-PANDA-03 --clear-bobfiles --screens-dir /epics/opi


