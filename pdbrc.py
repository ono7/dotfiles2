"""pdb++ configuration file

Jose Lima
2019-02-11 08:30

making pdb++ a little prettier to look at

requires:
    pip install pdbpp pygments

symlink:
    ln -sf ~/.dotfiles/pdbrc.py ~/.pdbrc.py
"""
import pdb


class Config(pdb.DefaultConfig):
    encoding = "utf-8"
    sticky_by_default = True
    truncate_long_lines = False

    #     prompt = "pdb> "
    current_line_color = 154
    #     editor = "${EDITOR:-vim}"

    #     def __init__(self):
    #         pass

    def setup(self, pdb):
        # make 'l' an alias to 'longlist'
        # Pdb.do_l = Pdb.do_longlist
        Pdb = pdb.__class__
        Pdb.do_st = Pdb.do_sticky
