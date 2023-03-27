# youtube: CAPsMAN WiFi Layer 1 Optimisation

https://www.youtube.com/watch?v=nCB4hL0f1VQ

## setting up caps man

**using l2 winbox**

1. log in to each device and reset configuration to "no configuration"

   system -> reset config -> no default config

2. give system a name

system -> identity

# add filter to help with roaming

```bash
/caps-man access-list
add action=accept interface=any signal-range=-87..120
add action=reject interface=any signal-range=-120..-88
```

# limit rates to higher rates, add more aps per room, lower power levels to 10 - 20db

```bash
/caps-man rates
add basic=12Mbps name=Rates1 supported=\
12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
```

# You should avoid Tx powers of more than 6dbm on 2.4 GHz with multiple cap setups.

# use /export to get plain text config, use /import verbose=yes filen-name=my.cfg

this will allow to import lines of config uploaded through the file manager, rename or set interfaces
in microtik router first for this to work efficiently

# turn off wps, reduces beacon size and you get more air time

# measure all APs in the same channel, to make sure they can see each other only abouve -70dbm

# you can do it from capsman

# removve 6 and 9 mbps from 5ghz

# disable b/g/n and use only g/n in 2.4ghz, also only n/ac in 5ghz in each radio
