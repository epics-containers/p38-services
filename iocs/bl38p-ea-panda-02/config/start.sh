#!/bin/bash
mkdir -p /epics/opi

pandablocks-ioc softioc bl38p-mo-panda-02 BL38P-EA-PANDA-02 --clear-bobfiles --screens-dir /epics/opis


