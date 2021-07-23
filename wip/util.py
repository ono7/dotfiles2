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
        self.k1_container = None
        self.k2_container = None
        self.parent_line = line
        self._is_parent = self._init_parent()
        self.list = []
        self.dict = {}
        self.active_container = None

    def _init_parent(self):
        if self._rex["is_parent"].search(self.parent_line):
            self._ret_keys()
            return True
        return False

    def is_parent(self):
        return self._is_parent

    def get_keys(self):
        return self.k1, self.k2

    def container(self):
        if self.k2:
            self.dict.setdefault(self.k1, {}).setdefault(self.k2, {})
            return self.dict
        self.dict.setdefault(self.k1, {})
        return self.dict

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


def clean_data_chunk(chunk):
    """ remove space around chunk and remove empty lines """
    empty_lines = re.compile(r"[\n]+")
    c = chunk.strip()
    c = empty_lines.sub("\n", chunk)
    return c
