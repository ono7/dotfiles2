#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'

1. keep track of parent key
2. make policies based on parent key if its "special"


"""

import regex as re
from json import dumps
from util import Stack, Container, clean_data_chunk, get_single_data_item


PARSERS = {"tlm": ""}


def get_line_parser(k: str) -> dict:
    return PARSERS.get(k, ParseDefault)


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


def get_keys(line):
    """returns keys to be used for dict nodes
    level1 is root key, level2 is to be used for nesting
    { "level1" : { "level2": {}}}
    """
    results = re.findall("[^{ ]", line)
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


def ret_obj(data, st=None):
    """recursively do magical things"""
    node = {}
    stack = Stack()
    if st:
        stack = st
    for index, line in enumerate(data):
        if stack.update_state(line):
            return node
        if len(re.findall("[{}]", line)) == 2:
            level1, results = get_single_line_item(line)
            node.setdefault(level1, results)
        elif not stack.is_balanced():
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


d1 = """level1key level1node level2key {

    k v

}"""

# d1 = """single level item {}"""


def parse_policy(data, stack):
    data_size = len(data)
    if data_size == 1:
        node = get_single_data_item(data[0])
        return node

    __import__("pdb").set_trace()
    node = Container(data[0])
    for index, line in enumerate(data):
        stack.update_state(line)
        if stack.is_balanced():
            return node.converts
        print(line, index)
    return node


parse_policy(clean_data_chunk(d1).splitlines(), stack=Stack())
# print(dumps(parse_policy(data.splitlines(), stack=Stack()), indent=2))
