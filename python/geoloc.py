#!/usr/bin/env python3
""" Cleans address strings and fetches geolocation data.
    Author:  Jose Lima (jlima)
    Date:    2024-01-04  22:48
"""
import requests
import urllib.parse
import re

address = "600 S. Collier Street, Marco Island, USA"

headers = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0",
}

bad = ["St", "Street", "Blvd", "Avenue", "Ave", "Road", "Rd", "Lane", "Ln"]


def make_re_pattern(mylist):
    """Returns regex pattern to 'or' aaa|a|a longest match first"""
    mylist.sort(key=len, reverse=True)
    return "|".join(map(re.escape, mylist))


def clean_address(address, pattern_list):
    """Clean the address by removing specified chars and extra spaces"""
    address = re.sub(r"[.]", "", address)
    address = re.sub(r"\s+", " ", address)
    address_trap_patterns = f"\\b{make_re_pattern(pattern_list)}\\b"
    return re.sub(address_trap_patterns, "", address, flags=re.IGNORECASE)


filtered_address = clean_address(address, bad)

print(f"this is my filtered addresses: {filtered_address}")


# make query URL safe incase of utf-8 chars
safe_address = urllib.parse.quote(filtered_address)

print(address)
url = f"https://nominatim.openstreetmap.org/search?q={safe_address}&format=jsonv2"
response = requests.get(url, headers=headers)
print(response.text)


# latitude, longitude = get_lat_long(address)
