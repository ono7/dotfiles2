#!/usr/bin/env python
""" converts things to JSON

    Thu Jul 22 00:09:24 2021

    __author__ = 'Jose Lima'
"""

from json import dumps
from base64 import b64encode
from util import (
    clean_data_chunk,
    parse_kv,
    create_new_objects,
)


lines = """ltm virtual export_me {
    description "THIS IS A DESC!!! {} }{{{}}}"
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
        policies4 {
            linux-high1 { }
       }
    }
}
"""

lines = """analitics gui-widget /Common/uidasf821312b {
    cent-report-destination-type self
    guie-pagecode _ov_test
    metrics { count drop_count total_count }
    profiles {
        asm-longprofileblahblahblah { }
        test {
            pr1 val1
        }
    }
    metrics2 { }
    module d1test
    order-on-page 2
    period 86400
    username first
    view-by d1_action
    widget-type 2
}
"""


# TODO: 07/27/2021 |  deal with special structures, e.g. asm
def parse_policy(policy):
    """ parse a stanza object from f5 and return python dict """
    lines = clean_data_chunk(policy).splitlines()
    storage_stack = []
    obj_stack = []
    for index, line in enumerate(lines):
        # __import__("ipdb").set_trace(context=5)
        if line.strip() == "}" and this_stack.is_balanced():
            if storage_stack[-1].parent and len(storage_stack) != 1:
                storage_stack[-1].parent.update(storage_stack[-1].get_store())
                storage_stack.pop()
                this_stack = obj_stack.pop()
            continue
        if line.strip() == "}":
            this_stack.update_state(line)
            if this_stack.is_balanced() and len(obj_stack) != 0:
                this_stack = obj_stack.pop()
                if storage_stack[-1].parent and len(storage_stack) != 1:
                    storage_stack[-1].parent.update(storage_stack[-1].get_store())
                    storage_stack.pop()
                continue
        if line.endswith("{"):  # TODO: 07/27/2021 | deal with special structures here
            this_stack = create_new_objects(line, storage_stack, obj_stack)
            continue
        storage_stack[-1].update(parse_kv(line))
    storage_stack[0].update({"ori_cfg_b64": f"{b64encode(policy.encode())}"})
    return storage_stack[0].get_store()


print(dumps(parse_policy(lines), indent=2))
print(lines)
