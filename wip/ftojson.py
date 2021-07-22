#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'

"""

import regex as re
from json import dumps

# data = """auth radius-server /Common/system_auth_name1 {
#     single_line2 { test2 test2 test2 test3 }
#     single_line3 { }
#     secret superdupersecret=
#     server 10.1.1.1
#     test {
#          test1 inner1
#          test2 inner1
#    }
# }
# """
data = """ltm virtual export_me {
    destination 10.1.30.30:https
    ip-protocol tcp
    mask 255.255.255.255
    policies {
        linux-high { }
    }
    pool test-pool
    source 0.0.0.0/0
    source-address-translation {
        type automap
    }
    translate-address enabled
    translate-port enabled
    vs-index 2
}
"""
# TODO: 07/22/2021 | fix part for ASM line
data = """ltm virtual export_me {
    destination 10.1.30.30:https
    ip-protocol tcp
    mask 255.255.255.255
    policies {
        linux-high { }
    }
    pool test-pool
    profiles {}
    source 0.0.0.0/0
    source-address-translation {
        type automap
    }
    translate-address enabled
    translate-port enabled
    vs-index 2
}
"""


def get_keys(line):
    """returns keys to be used for dict nodes
    level1 is root key, level2 is to be used for nesting
    { "level1" : { "level2": {}}}
    """
    results = re.findall("[^{ ]+", line)
    if results:
        if len(results) > 1:
            level2 = results.pop(-1)
            level1 = ":".join(results)
            return level1, level2
        level1, level2 = results[0], None
    return level1, level2


def get_single_line_item(line):
    """if we find a single line with {}
    we will extract key and values as a list
    """
    g1, g2 = re.search("(\S+).*?{([^{}]*)}", line).groups()
    return g1, g2.split()


def ret_obj(data, s=None):
    """recursively do magical things"""
    node = {}
    stack = []
    if s:
        stack = s
    for index, line in enumerate(data):
        if line.strip() == "}":
            stack.pop()
            if len(stack) == 0:
                return node
            else:
                continue
        if len(re.findall("[{}]", line)) == 2:
            level1, results = get_single_line_item(line)
            node.setdefault(level1, results)
        elif "{" in line:
            stack.append("{")
            level1, level2 = get_keys(line)
            if level2:
                node.setdefault(level1, {}).setdefault(level2, {})
                results = ret_obj(data[index + 1 :], stack)
                node[level1][level2].update(results)
                return node
            else:
                node.setdefault(level1, {})
                results = ret_obj(data[index + 1 :], stack)
                node[level1].update(results)
                return node

        else:
            k, v = re.findall("\S+", line)
            node.setdefault(k, v)
    return node


print(dumps(ret_obj(data.splitlines()), indent=2))
