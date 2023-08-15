#!/usr/bin/env python3
"""basic flask app

    Author: Jose Lima
    Date: 2023-08-14 16:07 CST


"""

from flask import Flask, redirect

app = Flask(__name__)


@app.route("/contacts")
def contacts():
    pass


@app.route("/")
def hello():
    return redirect("/contacts")
