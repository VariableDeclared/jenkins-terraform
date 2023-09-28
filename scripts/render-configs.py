#!/bin/env python3
import argparse
import yaml

O7K_CLOUD_CONFIG = {
    "clouds": {
        "openstack_cloud": {
            "type": "openstack",
            "auth-types": [
                "access-key",
                "userpass"
            ],
            "regions": {
                "RegionOne": {
                    "endpoint": ""
                }
            },
            "ca-certificates": []
        }
    }
}

parser = argparse.ArgumentParser()
parser.add_argument("ca", help="path to the Openstack CA certificate", required=True)
parser.add_argument("keystone-url", dest="keystone_url", help="keystone URL", required=True)
parser.add_argument("dest", required=False, default="openstack-cloud.yaml")

def render_configs(args):
    O7K_CLOUD_CONFIG["clouds"]["openstack_cloud"]["regions"]["RegionOne"].update({
        "endpoint": args.keystone_url
    })
    ca_cert_content = None
    with open(args.ca, 'r') as fh:
        ca_cert_content = fh.read()

    O7K_CLOUD_CONFIG["clouds"]["openstack_cloud"]["ca-certificates"] = ca_cert_content
    
    with open(args.dest, 'w') as fh:
        fh.write(yaml.safe_dump(O7K_CLOUD_CONFIG))

    print("Rendered credential config")

if __name__ == "__main__":
    args = parser.parse_arguments()
    render_configs(args)