#!/usr/bin/env python
""" implements new stack

    Fri Jul 23 13:11:27 2021

    __author__ = 'Jose Lima'

"""

import re


class Stack:
    def __init__(self):
        self.stack = []
        self.state = None

    def update_state(self, line):
        if line.endswith("{"):
            self.stack.append("{")
        elif line.strip() == "}":
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


class Container:
    _rex = {"is_parent": re.compile(r"^\w.*?{$"), "ret_keys": re.compile(r"[^{ ]+")}

    def __init__(self, line):
        self.k1 = None
        self.k2 = None
        self.parent_line = line
        self._is_parent = self._init_parent()
        self.active_container = None
        if self._is_parent:
            self.active_container = self.set_dict()

    def _init_parent(self):
        if self._rex["is_parent"].search(self.parent_line):
            self._ret_keys()
            return True
        return False

    def is_parent(self):
        return self._is_parent

    def get_keys(self):
        return self.k1, self.k2

    def set_dict(self):
        d = {}
        if self.k2:
            d.setdefault(self.k1, {}).setdefault(self.k2, {})
            return d
        d.setdefault(self.k1, {})
        return d

    def container(self):
        return self.active_container

    def _ret_keys(self):
        """returns keys to be used for dict nodes
        k1 is root key, k2 is to be used for nesting
        {"k1" : {"k2": {}}}
        when only k1 exists:
            {"k1" : {}}
        """
        results = self._rex["ret_keys"].findall(self.parent_line)
        if results:
            if len(results) > 1:
                self.k2 = results.pop(-1)
                self.k1 = ":".join(results)
                return self.k1, self.k2
            self.k1, self.k2 = results[0], None
        return self.k1, self.k2


def get_single_data_item(data):
    """if we find a single data with {}
    we will extract key and values as a list
    """
    g1, g2 = re.search("(\S+).*?{([^{}]*)}", data).groups()

    return {g1: g2.split()}


def clean_data_chunk(chunk):
    """ remove space around chunk and remove empty lines """
    empty_lines = re.compile(r"[\n]+")
    c = chunk.strip()
    c = empty_lines.sub("\n", chunk)
    return c
