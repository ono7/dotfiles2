#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'
"""

from json import dumps
from util import (
    Stack,
    Storage,
    clean_data_chunk,
    parse_kv,
    is_parent,
)

lines = """ltm virtual export_me {
    policies {
        linux-high { }
    }
    pool test-pool
    pool1 test-pool
}
"""

# lines = """ltm virtual export_me {
#     pool test-pool
#     block1 {
#         block1 block1
#     }
#     block2 {
#         block2 block2
#         block3 {
#             block3 block3
#         }
#     }
# }
# """

# lines = """ltm virtual export_me {
#     pool test-pool
#     block1 {
#         block1 block1
#         embedblock {
#             em1 em1
#             em2 em2
#             em3 em2
#             embed2 {
#                 test test
#             }
#         }
#     }
#     pool2 test-pool2
#     pool3 test-pool3
#     block2 {
#         block2 block2
#     }
# }
# """

data = clean_data_chunk(lines)


storage_stack = []
stack_of_stacks = []


def create_new_objects(line, node=None, level=None):
    """if node is defined shift stack so that level and object are aligned
    if there is a previous node, we create a reference to it for updating
    on the next cycle
    """
    new_node = Storage(*is_parent(line))
    if node:
        storage_stack.insert(level, new_node)
        new_node.parent = node
    else:
        storage_stack.append(new_node)
    new_stack = Stack()
    new_stack.update_state(line)
    stack_of_stacks.append(new_stack)
    return new_stack, new_node


level = -1
for line in lines.splitlines():
    __import__("ipdb").set_trace(context=5)
    if line.strip() == "}" and stack.is_balanced():
        level -= 1
        continue
    if line.strip() == "}":
        stack.update_state(line)
        if stack.is_balanced() and len(stack_of_stacks) != 0:
            stack = stack_of_stacks.pop()
            level -= 1
            continue
    if line.endswith("{"):
        level += 1
        try:
            if node.parent:
                node.parent.update(node.get_store())
            stack, node = create_new_objects(line, node, level)
        except NameError:
            stack, node = create_new_objects(line)
        finally:
            continue
    storage_stack[level].update(parse_kv(line))


print(stack_of_stacks)
print(storage_stack)

root = storage_stack.pop(0)
# while len(storage_stack) != 0:
#     n = storage_stack.pop(0)
#     root.update(n.get_store())

print(dumps(root.get_store(), indent=2))

todos = """
done 1. strip first line to create root object
done 2. parse until we find another parent, push old parent to stack, update current object
done -> using obj stack 4. keep track of objects and update sequences
    factory function?
done 5. find end of current object, using Stack() and update final structure and pop from stack
done 6. update parent object
done 7. if line is not parent object, continue updating current opbject

8. if nested object, should update last object

"""
