#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'

"""

import regex as re

data = """auth radius-server /Common/system_auth_name1 {
    secret superdupersecret=
    server 10.1.1.1
}
"""


def getKeys(line):
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


def ret_obj(data):
    # __import__("pdb").set_trace()
    node = {}
    __import__("pdb").set_trace()
    for index, line in enumerate(data):
        if line == "}":
            return node
        if "{" in line:
            level1, level2 = getKeys(line)
            if level2:
                node.setdefault(level1, {}).setdefault(level2, {})
                results = ret_obj(data[index + 1 :])
                node[level1][level2].update(results)
                return node
            else:
                node.setdefault(level1, {})
                results = ret_obj(data[index + 1 :])
                node[level1].update(results)
                return node

        else:
            k, v = re.findall("\S+", line)
            node.setdefault(k, v)
    return node


ret_obj(data.splitlines())
