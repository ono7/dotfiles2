#!/usr/bin/env python3
"""
    Author:  Jose Lima (jlima)
    Date:    2024-01-07  16:16
    pytest example
"""
import requests


def get_api():
    r = requests.get("https://httpbin.org/ip")
    if r.status_code == 200:
        return r.json()["origin"]


print(get_api())
