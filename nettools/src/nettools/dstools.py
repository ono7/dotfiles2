""" tools for handling datastructures """


class UniqueList:
    """ returns a unique iterable list object """

    def __init__(self, items):
        self.items = []
        for item in items:
            self.append(item)

    def append(self, item):
        if item not in self.items:
            self.items.append(item)

    def __getitem__(self, index):
        return self.items[index]
