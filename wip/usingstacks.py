#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'
"""

import regex as re
from json import dumps
from util import Stack, clean_data_chunk, parse_kv, parse_singleton, is_parent

lines = """ltm virtual export_me {
    policies {
        linux-high { }
    }
    pool test-pool
    pool1 test-pool
    pool2 test-pool
    pool3 test-pool
}
"""

lines = """ltm virtual export_me {
    pool test-pool
    pool1 test-pool
    pool2 test-pool
    testl2 {
        ktest vtest
        ktest1 vtest
        ktest2 vtest
        ktest3 vtest
        ktest4 vtest
    }
}
"""

data = clean_data_chunk(lines)


class StoreDict:
    def __init__(self, k1, k2):
        self.k1 = k1
        self.k2 = k2
        if k2:
            self.storage = {k1: {k2: {}}}
        else:
            self.storage = {k1: {}}

    def update(self, data):
        if self.k2:
            self.storage[self.k1][self.k2].update(data)
        else:
            self.storage[self.k1].update(data)

    def get_store(self):
        return self.storage


storage_stack = []
stack_of_stacks = []

for line in lines.splitlines():
    if line.strip() == "}":
        stack.update_state(line)
        if stack.is_balanced():
            break
    if line.endswith("{"):
        try:
            if isinstance(node, StoreDict):
                storage_stack.append(node)
        except NameError:
            pass
        node = StoreDict(*is_parent(line))
        stack = Stack()
        stack.update_state(line)
        continue
    node.update(parse_kv(line))

__import__("pdb").set_trace()
node.get_store()
root = storage_stack.pop()
root.update(node.get_store())

print(dumps(root.get_store(), indent=2))


"""
1. strip first line to create root object
2. parse until we find another parent, push old parent to stack, update current object
4. keep track of objects and update sequences
    factory function?
5. find end of current object, using Stack() and update final structure and pop from stack
6. update parent object
7. if line is not parent object, continue updating current opbject
"""
