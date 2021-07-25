#!/usr/bin/env python
""" implements new stack

    Fri Jul 23 13:11:27 2021

    __author__ = 'Jose Lima'

"""

import re


## policy helpers ##


def clean_data_chunk(chunk):
    """ remove space around chunk and remove empty lines """
    empty_lines = re.compile(r"[\n]+")
    c = chunk.strip()
    return empty_lines.sub("\n", c)


class Stack:
    def __init__(self):
        self.stack = []
        self.state = None
        self.current = None

    def update_state(self, data, index):
        self.current = data[index]
        if self.current.endswith("{"):
            self.stack.append("{")
        elif self.current.strip() == "}":
            self.stack.pop()
        if len(self.stack) == 0:
            self.state = True
        else:
            self.state = False
        return self.state

    def is_balanced(self):
        return self.state

    def get_stack(self):
        return self.stack


### parsers ###


def parse_singleton(data):
    g1, g2 = re.search("(\S+).*?{([^{}]*)}", data).groups()

    return {g1: g2.split()}


re_quotes = re.compile(r'\b(\S+) "([^"]+)"$')
re_kv = re.compile(r"\S+")
re_keys = re.compile(r"[^{ ]+")


def get_keys(line):
    results = re_keys.findall(line)
    if results:
        if len(results) > 1:
            level2 = results.pop(-1)
            level1 = ":".join(results)
            return level1, level2
        level1, level2 = results[0], None
    return level1, level2


def parse_kv(line):
    try:
        if line.endswith('"'):
            return re_quotes.search(line).groups()
        else:
            return re_kv.findall(line)
    except Exception as e:
        print(f"error parsing {line}, the exeption was: {e}")
        raise


def get_container_type(current_line, next_line):
    l1 = current_line.strip()
    l2 = next_line.strip()
    if re.search("{(\s*?)?}$", l1) and re.search("^{", l2):
        return {}, []
    return {}
