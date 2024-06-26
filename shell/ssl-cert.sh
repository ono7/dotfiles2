#!/usr/bin/env bash
#
#  Author:  Jose Lima (jlima773)
#  Date:    2024-06-26 13:38

set -Eeuo pipefail

openssl genpkey -algorithm RSA -out server.key
openssl req -new -x509 -key server.key -out server.crt -days 5000 -subj "/C=US/ST=TX/L=Northlake/O=marriott.com/OU=NetworkDevOps/CN=localhost"
