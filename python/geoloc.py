#!/usr/bin/env python3
""" sanitizes address strings and fetches geolocation data.
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

bad_word_list = ["St", "Street", "Blvd", "Avenue", "Ave", "Road", "Rd", "Lane", "Ln"]


def make_re_pattern(mylist):
    """Returns regex pattern to 'or' aaa|a|a longest match first"""
    mylist.sort(key=len, reverse=True)
    return "|".join(map(re.escape, mylist))


def sanitize_address(address, pattern_list):
    """sanitize the address by removing unwanted chars and extra spaces"""
    address = re.sub(r"[.]", "", address)
    address = re.sub(r"\s+", " ", address)
    address_trap_patterns = f"\\b{make_re_pattern(pattern_list)}\\b"
    address = re.sub(address_trap_patterns, "", address, flags=re.IGNORECASE)
    return urllib.parse.quote(address)


def check_api_response(resp):
    """Get lat and lon or raise exception
    resp(list): response from openstreetmap.org
    caller is responsible for handling exception
    """
    try:
        payload = resp.json()
        if resp.status_code == 200 and isinstance(payload, list):
            lat = payload[0]["lat"]
            lon = payload[0]["lon"]
            return True, False, {"data": [{"latitude": lat, "longitude": lon}]}

    except Exception as e:
        raise Exception(f"{e}, data: {resp}")


def get_coordinates(address_str):
    url = f"https://nominatim.openstreetmap.org/search?q={address_str}&format=jsonv2&limit=1"
    failed, lat, lon = check_api_response(requests.get(url, headers=headers))
    return failed, lat, lon


print(get_coordinates(sanitize_address(address, bad_word_list)))

# latitude, longitude = get_lat_long(address)
