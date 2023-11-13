#!/bin/bash
pod=$(kubectl get pods --no-headers -l app=bl38p-opis -o custom-columns=:metadata.name)
kubectl cp  $(dirname ${0})/index.bob $pod:/usr/share/nginx/html/bl38p-ea-ioc-03/index.bob
