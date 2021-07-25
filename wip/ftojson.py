#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'

1. keep track of parent key
2. make policies based on parent key if its "special"


"""

import regex as re
from json import dumps
from util import Stack, clean_data_chunk, parse_kv, parse_singleton, is_parent


lines = """ltm virtual export_me {
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
    vs-cursor 2
}
"""


lines = """ltm virtual export_me {
    policies {
        linux-high { }
    }
    pool test-pool
}
"""


def get_children(lines, parent, node, stack=None):
    k1, k2 = is_parent(parent)
    results = parse_policy(lines, stack)
    if k2:
        node.setdefault(k1, {}).setdefault(k2, {})
        node[k1][k2].update(results)
    else:
        node.setdefault(k1, {})
        node[k1].update(results)
    return node


cursor = 0


def parse_policy(lines, stack=None):
    global cursor
    if len(lines) == 1 and len(lines[0]) != 1:
        node = parse_singleton(lines[0])
        return node
    node = {}
    line = lines[cursor]
    stack.update_state(line)
    if stack.is_balanced():
        return node
    if line.endswith("{"):
        newStack = Stack()
        node = get_children(lines[cursor + 1 :], line, node, newStack)
        if len(lines[cursor + 1 :]) > 0:
            results = parse_policy(lines[cursor + 1 :], stack)
            node.update(results)
    else:
        k, v = parse_kv(line, stack)
        node.setdefault(k, v)
        cursor += 1
    return node


print(
    dumps(parse_policy(clean_data_chunk(lines).splitlines(), stack=Stack()), indent=2)
)
# try:
#     print(
#         dumps(
#             parse_policy(clean_lines_chunk(lines).splitlines(), stack=Stack()), indent=2
#         )
#     )
# except:
#     __import__("pdb").post_mortem()
