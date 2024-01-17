
import requests

NAUTOBOT_API_BASE_URL = "https://your-nautobot-api-url.com/api/"
NAUTOBOT_API_TOKEN = "your-nautobot-api-token"

def get_devices_by_platform(platform_name):
    headers = {
        "Authorization": f"Token {NAUTOBOT_API_TOKEN}",
        "Accept": "application/json",
    }

    # Query parameters for filtering devices by platform
    params = {
        "platform": platform_name,
    }

    try:
        response = requests.get(f"{NAUTOBOT_API_BASE_URL}dcim/devices/", headers=headers, params=params)
        response.raise_for_status()  # Raise an exception for non-2xx responses
        devices = response.json()
        return devices

    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")
        return None

def main():
    platform_name = "Your Platform Name"  # Replace with the desired platform name
    devices = get_devices_by_platform(platform_name)

    if devices:
        print(f"Devices with platform '{platform_name}':")
        for device in devices:
            print(f"ID: {device['id']}, Name: {device['name']}, Platform: {device['platform']['name']}")
    else:
        print("No devices found.")

if __name__ == "__main__":
    main()
