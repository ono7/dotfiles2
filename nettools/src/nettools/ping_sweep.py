#!/usr/bin/env python

import subprocess
import ipaddress
import sys

alive = []
# subnet = ipaddress.ip_network("192.168.1.0/23", strict=False)


def ping_sweep(network_block):
    subnet = ipaddress.ip_network(network_block, strict=False)
    for h in subnet.hosts():
        h = str(h)
        retval = subprocess.call(["ping", "-c1", "-n", "-i0.1", "-W1", h])
        if retval == 0:
            alive.append(h)
    for ip in alive:
        print(ip + " is alive")


def main():
    """ entry point """
    ping_sweep(sys.argv[1])


if __name__ == "__main__":
    sys.exit(main())
