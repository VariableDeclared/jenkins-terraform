#!/bin/bash

O7K_KEYSTONE_URL=$1
O7K_CA_CERT=$2
OS_PASSWD=$3
OS_DOMAIN_NAME=$4
OS_TENANT_NAME=$5
OS_USERNAME=$6

cat <<END > ./openstack-cloud.yaml
clouds:
  openstack_cloud:
    type: openstack
    auth-types: [access-key, userpass]
    regions:
      RegionOne:
        endpoint: $O7K_KEYSTONE_URL
    ca-certificates:
    - |
      $O7K_CA_CERT
END

cat <<END > ./openstack-credential.yaml
credentials:
   openstack_cloud:
     auth-type: userpass
     domain-name: ""
     password: "$OS_PASSWD"
     project-domain-name: "$OS_DOMAIN_NAME"
     tenant-name: "$OS_TENANT_NAME"
     user-domain-name: "$OS_DOMAIN_NAME"
     username: "$OS_USERNAME"
END

juju add-cloud --client -f openstack-cloud.yaml || true
juju add-credential openstack_cloud --client -f openstack-credential.yaml || true
