#!/bin/bash

ca=$(env TZ=America/Los_angeles date +'%I:%M%p %Z')
chi=$(env TZ=America/Chicago date +'%I:%M%p %Z')
az=$(env TZ=America/Phoenix date +'%I:%M%p %Z')
ny=$(env TZ=America/New_york date +'%I:%M%p %Z')
echo $ca $az $chi $ny
