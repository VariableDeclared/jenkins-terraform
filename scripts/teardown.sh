#!/bin/bash

for domain in  Engineering Support Administration; do openstack domain set --disable $domain; done
juju kill-controller -t 0 openstack-controller
terraform apply -destroy -auto-apply