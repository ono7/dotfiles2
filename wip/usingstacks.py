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

lines = """ltm virtual export_me {
    policies {
        linux-high { }
    }
    pool test-pool
    pool1 test-pool
    policies1 {
        linux-high { }
        policies8 {
            linux-high1 { }
            linux-high2 { }
            linux-high3 { }
            linux-high4 { }
            policies4 {
                linux-high1 { }
           }
        }
    }
    policies_last {
        linux-high { }
    }
}
"""

data = clean_data_chunk(lines)


storage_stack = []
stack_of_stacks = []


def create_new_objects(line, node=None, level=None):
    """if node is defined shift stack so that level and object are aligned
    if there is a previous node, we create a reference to it for updating
    on the next cycle
    """
    new_node = Storage(*is_parent(line))
    if len(storage_stack) > 0:
        new_node.parent = storage_stack[-1]
    storage_stack.append(new_node)
    new_stack = Stack()
    new_stack.update_state(line)
    stack_of_stacks.append(new_stack)
    return new_stack, new_node


for line in lines.splitlines():
    # __import__("ipdb").set_trace(context=5)
    if line.strip() == "}" and stack.is_balanced():
        if storage_stack[-1].parent and len(storage_stack) != 1:
            storage_stack[-1].parent.update(storage_stack[-1].get_store())
            storage_stack.pop()
            stack = stack_of_stacks.pop()
            node = storage_stack[-1]
        continue
    if line.strip() == "}":
        stack.update_state(line)
        if stack.is_balanced() and len(stack_of_stacks) != 0:
            stack = stack_of_stacks.pop()
            if storage_stack[-1].parent and len(storage_stack) != 1:
                storage_stack[-1].parent.update(storage_stack[-1].get_store())
                storage_stack.pop()
                node = storage_stack[-1]
            continue
    if line.endswith("{"):
        try:
            stack, node = create_new_objects(line, node)
        except NameError:
            stack, node = create_new_objects(line)
        finally:
            continue
    storage_stack[-1].update(parse_kv(line))


print(stack_of_stacks)
print(storage_stack)

root = storage_stack.pop(0)
print(dumps(root.get_store(), indent=2))
print(lines)
