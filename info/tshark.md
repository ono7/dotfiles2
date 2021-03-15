#########################################################################
###                              TSHARK                               ###
#########################################################################




### TSHARK: standard operating commands

tshark -D: get interface list









### TSHARK: Reconfigure as regular user

1. dpkg-reconfigure wireshark-common

2. usermod -a -G wireshark $USER
  user needs to be part of wireshark group to run non-root

3. activate group: newgrp wireshark <- adds group to current user righta away







### TSHARK: Promiscious mode (capture packets not destine to us | useful in span ports)



* ifconfig <int> promisc

ifconfig tap0

  tap0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

* ifconfig tap0 promisc

ifconfig tap0
  tap0: flags=4419<UP,BROADCAST,RUNNING,PROMISC,MULTICAST>  mtu 1500



### TSHARK: Save capture to files/pcap


* capture 20 packets on tap0 int, write to tap0.pcap

  tshark -i tap0 -c 20 -w tap0.pcap


### TSHARK: Read packets from pcap file | show packet details -V

* scroll buffer with less
  tshark -r test.pcap | less

* show 1 packet
tshark -r test.pcap -c1

* show 1 packet with all details
tshark -r test.pcap -c1 -V



### TSHARK: Export data  | json ise useful for finding filter types!!

tshark -T x: show all formats supported


* export brief data about a packet

tshark -r tap0.pcap -T psml

* export detailed data about a packet

tshark -r tap0.pcap -T pdml


tshark -r tap0.pcap -T json

### TSHARK: convert pcap/pdml to html (useful for formatting to html)

prod3 ❯ locate pdml2html
/usr/share/wireshark/pdml2html.xsl

* need utility to convert

apt-get install xsltproc


* convert dmpl

[ xsltproc | <path to pdml2html.xsl> input_pdml.pdml > output.html ]
xsltproc /usr/share/wireshark/pdml2html.xsl tap0.pdml > tap0.html






### TSHARK: Capture filters

onboard help:

man pcap-filter

ref:
* complete list of supported BPF filters/syntax

  https://www.wireshark.org/docs/man-pages/pcap-filter.html





capture filters are written in BPF format, display filters are written in wireshark format

* capture filters are pre filteres

* display filters are used to parse data after capture filters





### TSHARK: Display filters


tshark -r tap0.pcap -T json (get the filter fields we can use to get data)

tshark -r tap0.pcap -Y "http.request.method==GET" -V








### TSHARK: Display filters | inline quickies

* get filter options: tshark -r tap0.pcap -T json
* get filter options inline:
tshark -Y "http.request.method==GET" -f "tcp port 80" -c2 -V








### TSHARK: Display filters | extract fields | wifi


* get all options for the packet tshark -r wlan.pcap -c2 -T json

* filter by beacon frames, extract wlan.ssid fields

tshark -r WiFi_traffic.pcap -n -Y 'wlan.fc.type_subtype==0x0008' -T fields -e wlan.ssid -e wlan.bssid









### TSHARK: Display filters | extract fields | http | tshark headers -E headers=y



* print with headers
tshark -r HTTP_traffic.pcap -Y 'http.request.method=="GET"' -Tfields -e "http.host" -e "http.request.uri" -E header=y






### TSHARK: Statistics (-z option) | io,phs,+filter


tshark -r pcap -z io,phs (-q to quite and only see statistics)

===================================================================
Protocol Hierarchy Statistics
Filter:

radiotap                                 frames:66690 bytes:15014549
  wlan_radio                             frames:66690 bytes:15014549
      llc                                frames:3158 bytes:1295577
        eapol                            frames:6 bytes:1162
        ipv6                             frames:16 bytes:2136
          icmpv6                         frames:16 bytes:2136
        ip                               frames:3124 bytes:1291079
          udp                            frames:143 bytes:25311
            dhcp                         frames:6 bytes:2448
            dns                          frames:126 bytes:21131
            _ws.malformed                frames:5 bytes:2666
        arp                              frames:12 bytes:1200
===================================================================





* filter statistics by protocol

tshark -r pcap -z io,phs,ip -q




* filter statistics by fields

tshark -r WiFi_traffic.pcap -z io,phs,'wlan.bssid == 6c:19:8f:5f:81:74' -q

===================================================================
Protocol Hierarchy Statistics
Filter: wlan.bssid == 6c:19:8f:5f:81:74

radiotap                                 frames:5594 bytes:1270523
  wlan_radio                             frames:5594 bytes:1270523
    wlan                                 frames:5594 bytes:1270523
      wlan                               frames:1744 bytes:523913
      data                               frames:3580 bytes:728552
      llc                                frames:6 bytes:1162
        eapol                            frames:6 bytes:1162
===================================================================



* tshark -r HTTP_traffic.pcap -z io,phs,http -q





### TSHARK: Summaries & conversations and endpoints



* tshark -r WiFi_traffic.pcap -q -z endpoints,wlan,"wlan.bssid == 6c:19:8f:5f:81:74"

;================================================================================
IEEE 802.11 Endpoints
Filter:wlan.bssid == 6c:19:8f:5f:81:74
                       |  Packets  | |  Bytes  | | Tx Packets | | Tx Bytes | | Rx Packets | | Rx Bytes |
Motorola_31:a0:3b           3889        758363       3759          720584         130           37779
D-LinkIn_5f:81:6b           3551        722297         40            4984        3511          717313
D-LinkIn_5f:81:74           2014        541971       1703          521144         311           20827
Broadcast                   1466        447078          0               0        1466          447078
IntelCor_56:e1:04             99         24187         89           23457          10             730
Motorola_a9:7b:05             56         16968          0               0          56           16968
LgElectr_f6:69:dd             15          4545          0               0          15            4545
IntelCor_f2:32:30             14          4242          0               0          14            4242
Motorola_00:72:25             12          3636          0               0          12            3636
OneplusT_30:1f:6d              9          1216          3             354           6             862
IPv4mcast_fb                   9          1635          0               0           9            1635

;================================================================================


* tshark -r WiFi_traffic.pcap -q -z endpoints,ip,udp

;================================================================================
IPv4 Endpoints
Filter:udp
                       |  Packets  | |  Bytes  | | Tx Packets | | Tx Bytes | | Rx Packets | | Rx Bytes |
192.168.3.10                 140         24063         71            9975          69           14088
8.8.8.8                      126         21131         65           12740          61            8391
224.0.0.251                    8          1288          0               0           8            1288






### TSHARK: Conversation and filters | -z and wrong argument to get full list

tshark -r WiFi_traffic.pcap -q -z conversations,ip
tshark: Invalid -z argument "conversations,ip"; it must be one of:
     afp,srt
     ancp,tree
     ansi_a,bsmap
     ansi_a,dtap
     ansi_map
     bacapp_instanceid,tree
     bacapp_ip,tree
     bacapp_objectid,tree
     bacapp_service,tree
     camel,counter
     camel,srt
     collectd,tree
     conv,bluetooth
     conv,eth
     conv,fc
     conv,fddi
     conv,ip
     conv,ipv6




### TSHARK: Help on topics,  tshark -z help  (use the flag + help command)


tshark -z help
tshark help







### TSHARK: ring buffer / circular buffer / write fiels -> tshark -b fileszie:10000 -b files:5


files will be of size 10MB up to 5 files and will circle back around when they fill up to the last one








### TSHARK: Decode as/unknown protocols -d | -d x to get a list of options

usefull when we need to decode something that is unknown/encapsulated on non standard ports or is encrypted

* -d
tshark -r Call_to_VoiceMail-SIPTLS-RTP.pcap -Y "udp.port == 4000" -d udp.port==4000,rtp






#### TSHARK: view and set preferences | tshark -G currentprefs

tshark -G currentprefs

* view ssl options, or grep anything else

tshark -G currentprefs | grep ssl







### TSHARK: decrypting SSL streams



|-----------------------|------|----------|-------------|
| key_list command      | port | protocol | key         |
|-----------------------|------|----------|-------------|
| ssl.keys_list:0.0.0.0 | 443  | http     | private.key |
|-----------------------|------|----------|-------------|

1. checkout the clien cipher suite in wireshark to find out what cypher they support

2. with RSA we can decrypt with server key

tshark -r HTTPS_traffic_RSA_Exchange.pcap -o "ssl.keys_list:0.0.0.0,443,http,private.key" -V

tshark -r HTTPS_traffic_RSA_Exchange.pcap -o "ssl.keys_list:0.0.0.0,443,http,private.key" -z io,phs,ssl -q








### TSHARK: Python | automation/basics

refs:
  https://kiminewt.github.io/pyshark/


import pyshark
import sys

capture = pyshark.LiveCapture(interface='en0')

capture.sniff(timeout=10)




import pyshark
import sys

capture = pyshark.LiveCapture(interface=en0, bpf_filter=sys.argv[1])

for packet in capture.sniff_continously(packet_count=10):
  packet.pretty_print(packet)





