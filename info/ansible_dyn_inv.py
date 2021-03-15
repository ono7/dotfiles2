#!/usr/bin/env python
"""

Wed Apr 1 12:00:53 PM 2020

__author__ = "Jose Lima"

    use:

        * setup group vars to use

            my_vars = {
                "ansible_user": "jose.lima",
                "ansible_network_os": "nxos",
                "ansible_connection": "network_cli",
                "timeout": "5",
            }

        * create shell inventory

            my_inv = inv_shell()

        * add group and group_vars to inventory, pass it my_vars

            inv_add_group(my_inv, "groupName", grp_vars=my_vars)

        * add hosts to the inventory

"""

import json
from pprint import pprint

default_vars = {
    "ansible_user": "jose.lima",
    "ansible_network_os": "nxos",
    "ansible_connection": "network_cli",
    "timeout": "5",
}

ios_vars = {
    "ansible_user": "jose.lima",
    "ansible_network_os": "ios",
    "ansible_connection": "network_cli",
    "timeout": "5",
}


def inv_shell():
    """creates a shell inventory dictionary"""
    return {"_meta": {"hostvars": {}}}


def inv_add_group(inv, grp_name="default", grp_vars=default_vars):
    """adds an inventory group and its variables to a dictionary"""
    return inv.update({grp_name: {"hosts": [], "vars": grp_vars}})


def inv_add_host(inv, host, grp_name="default"):
    """add hosts to group"""
    inv[grp_name]["hosts"].append(host)


hosts = """
1.1.1.1
1.1.1.1
1.1.1.2
1.1.1.3
1.1.1.4
1.1.1.6
1.1.1.5
1.1.1.7
""".splitlines()

hosts = [x for x in hosts if x != ""]

my_inv = inv_shell()

inv_add_group(my_inv, grp_name="ios_devices", grp_vars=ios_vars)
inv_add_group(my_inv, grp_name="nxos_devices")

for host in hosts:
    inv_add_host(my_inv, host, grp_name="ios_devices")


pprint(my_inv)

# send json to ansible-playbook!
# print(json.dumps(my_inv))
