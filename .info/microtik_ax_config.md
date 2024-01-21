80Mzh wide channels (RANGES), for AX

Channel 42: 5210 MHz to 5290 MHz
Channel 58: 5290 MHz to 5370 MHz
Channel 106: 5510 MHz to 5590 MHz
Channel 122: 5610 MHz to 5690 MHz
Channel 138: 5735 MHz to 5815 MHz
Channel 155: 5775 MHz to 5855 MHz





/interface wifiwave2 channel
add frequency=2412,2432,2472 name=ch-2ghz width=20mhz
add frequency=5180,5260,5500 name=ch-5ghz width=20/40/80mhz

/interface wifiwave2 security
add authentication-types=wpa2-psk,wpa3-psk management-protection=allowed name=common-auth wps=disable passphrase=securepassword

/interface wifiwave2 configuration
add country="United States" name=common-conf security=common-auth ssid=CenturyLink1940

/interface wifiwave2
set [ find default-name=wifi1 ] channel=ch-2ghz configuration=common-conf configuration.mode=ap disabled=no
set [ find default-name=wifi2 ] channel=ch-5ghz configuration=common-conf configuration.mode=ap .ssid=CenturyLink1940 disabled=no
