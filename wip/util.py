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


def parse_kv(line):
    try:
        k, v = re.findall("\S+", line)
    except Exception as e:
        print(f"error parsing {line}, the exeption was: {e}")
        raise
    return k, v


def parse_quotes(line):
    parse = re.compile(r'\b(description) "([^"]+)"$')
    return parse.search(line)


def get_parser(current_line):
    l1 = current_line.strip()
    if re.search("^(description|caption)", l1):
        return parse_quotes
    return parse_kv


def get_container_type(current_line, next_line):
    l1 = current_line.strip()
    l2 = next_line.strip()
    if re.search("{(\s*?)?}$", l1) and re.search("^{", l2):
        return {}, []
    return {}
