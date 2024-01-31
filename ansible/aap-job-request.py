#!/usr/bin/env python3
"""
    Author:  Jose Lima (jlima)
    Date:    2024-01-31  16:12
    
"""

import requests
import json

# Ansible Tower details
tower_url = "http://your_ansible_tower_server/api/v2/job_templates/"
username = "your_username"
password = "your_password"
job_template_id = "your_job_template_id"  # Replace with your job template ID

# Endpoint for the specific job template
endpoint = f"{tower_url}{job_template_id}/launch/"

# Headers for the request
headers = {
    'Content-Type': 'application/json'
}

# Authentication
auth = (username, password)

# Data payload (if any required parameters for the job template)
data = json.dumps({})  # Replace with the necessary data for your job template

# Making the POST request
response = requests.post(endpoint, headers=headers, auth=auth, data=data)

# Checking the response
if response.status_code == 201:
    print(f"Job launched successfully: {response.json()}")
else:
    print(f"Failed to launch job: {response.status_code}, {response.text}")

# Handle response here (e.g., get job status, etc.)
