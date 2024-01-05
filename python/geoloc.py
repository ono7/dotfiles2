#!/usr/bin/env python3
"""
    Author:  Jose Lima (jlima)
    Date:    2024-01-04  22:48

"""
import requests
import urllib.parse



def get_lat_long(address):
    url_address = urllib.parse.quote(address)
    url = f"https://nominatim.openstreetmap.org/search?format=json&q={url_address}"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        try:
            lat = data[0]["lat"]
            lon = data[0]["lon"]
            return lat, lon
        except Exeption as e:
            return f"error {e}"


address = "600 S. Collier Street, Marco Island, USA"
latitude, longitude = get_lat_long(address)
print(f"Latitude: {latitude}, Longitude: {longitude}")
