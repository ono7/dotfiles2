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
    block1 {
        block1 block1
    }
    block2 {
        block2 block2
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


def create_new_object(line, stack=None, node=None):
    # if node:
    #     storage_stack.append(node)
    # if stack:
    #     stack_of_stacks.append(stack)
    node = StoreDict(*is_parent(line))
    stack = Stack()
    stack.update_state(line)
    storage_stack.append(node)
    stack_of_stacks.append(stack)
    return stack, node


for line in lines.splitlines():
    if line.strip() == "}" and stack.is_balanced():
        continue
    elif line.strip() == "}":
        stack.update_state(line)
        __import__("pdb").set_trace()
        if stack.is_balanced() and len(stack_of_stacks) != 0:
            stack = stack_of_stacks.pop()
            continue
        # # stack = stack_of_stacks.pop()
        # if not stack.is_balanced():
        #     continue
    if line.endswith("{"):
        try:
            last_node = node
            last_stack = stack
            stack, node = create_new_object(line, stack, node)
        except NameError:
            stack, node = create_new_object(line)
        finally:
            continue
    node.update(parse_kv(line))


print(stack_of_stacks)
print(storage_stack)

root = storage_stack[0]
for i, s in enumerate(storage_stack):
    if i > 0:
        root.update(s.get_store())

print(dumps(root.get_store(), indent=2))

# while len(storage_stack) > i:
#     print(dumps(storage_stack[0].update(storage_stack[i + 1].get_store()), indent=2))
#     i += 1


"""
done 1. strip first line to create root object
done 2. parse until we find another parent, push old parent to stack, update current object
done -> using obj stack 4. keep track of objects and update sequences
    factory function?
5. find end of current object, using Stack() and update final structure and pop from stack
6. update parent object
done 7. if line is not parent object, continue updating current opbject
"""
