#!/usr/bin/env python3
# chmod +x this_file

import requests
import json


def fetch_inventory_data():
    return [
        {
            "name": "server1",
            "ip": "192.168.1.101",
            "group": "web_servers",
            "test_var": "web_servers",
        },
        {
            "name": "server2",
            "ip": "192.168.1.102",
            "group": "web_servers",
            "test_var": "web_servers",
        },
        {
            "name": "server3",
            "ip": "192.168.1.102",
            "group": "db_servers",
            "test_var": "db_servers",
        },
    ]


def generate_ansible_inventory():
    inventory_data = fetch_inventory_data()
    inventory = {"_meta": {"hostvars": {}}}

    for host_data in inventory_data:
        host = host_data["name"]
        ip = host_data["ip"]
        group = host_data["group"]
        test_var = host_data["test_var"]

        # Group hosts based on their group name
        inventory.setdefault(group, {"hosts": []})
        inventory[group]["hosts"].append(host)

        # Store host variables (optional, but useful for host-specific configuration)
        inventory["_meta"]["hostvars"].setdefault(host, {})
        inventory["_meta"]["hostvars"][host]["ansible_host"] = ip
        inventory["_meta"]["hostvars"][host]["test_var"] = test_var

    return inventory


if __name__ == "__main__":
    ansible_inventory = generate_ansible_inventory()
    print(json.dumps(ansible_inventory, indent=2))
