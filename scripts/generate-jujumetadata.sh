#!/bin/bash

# $1 - path to novarc
# $2 - image ID
# $3 - OS series
# $4 - Region
# $5 - Openstack auth URL
mkdir -p ~/simplestreams/images
. $1

juju generate-image -d -i $2 -s $3 -r $4 -u $5 

