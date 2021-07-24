#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'

1. keep track of parent key
2. make policies based on parent key if its "special"


"""

import regex as re
from json import dumps
from util import Stack, clean_data_chunk, parse_kv, parse_singleton


data = """ltm virtual export_me {
    description "This is for export.  Export this description."
    destination 10.1.30.30:https
    ip-protocol tcp
    mask 255.255.255.255
    policies {
        linux-high { }
    }
    pool test-pool
    profiles {
    ASM_asm-policy-linux-high-security_policy { }
        clientssl {
        context clientside
        }
        http { }
        serverssl {
        context serverside
        }
        tcp-lan-optimized {

        context serverside
        }
        tcp-wan-optimized {
        context clientside
        }
        websecurity { }
    }
    source 0.0.0.0/0
    source-address-translation {
        type automap
    }
    translate-address enabled
    translate-port enabled
    vs-index 2
}
"""


d1 = """level1key level1node level2key {

    k1 v1
    k2 v2
    k3 v3

}"""


def get_keys(line):
    results = re.findall("[^{ ]+", line)
    if results:
        if len(results) > 1:
            level2 = results.pop(-1)
            level1 = ":".join(results)
            return level1, level2
        level1, level2 = results[0], None
    return level1, level2


def get_children(data, line, node, index, stack):
    k1, k2 = get_keys(line)
    if k2:
        node.setdefault(k1, {}).setdefault(k2, {})
        results = parse_policy(data[index + 1 :], stack)
        node[k1][k2].update(results)
        return node
    else:
        node.setdefault(k1, {})
        results = parse_policy(data[index + 1 :], stack)
        node[k1].update(results)
        return node


def parse_policy(data, stack):
    if len(data) == 1 and len(data[0]) != 1:
        node = parse_singleton(data[0])
        return node
    __import__("pdb").set_trace()
    node = {}  # TODO: 07/24/2021 | something that returns list or dict
    for index, line in enumerate(data):
        stack.update_state(data, index)
        if stack.is_balanced():
            continue
        if line.endswith("{"):
            node = get_children(data, line, node, index, stack)
            return node
        else:
            k, v = parse_kv(line)
            node.setdefault(k, v)
    return node


print(dumps(parse_policy(clean_data_chunk(d1).splitlines(), stack=Stack()), indent=2))
