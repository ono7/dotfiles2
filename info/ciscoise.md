# Cisco ISE

# return more then 20 default lines

For example, You can increase query size by 50 and page to 5 (5th page in groups
of 50) by appending query with ?size=50&page=5

# filtering, searching, paging

https://developer.cisco.com/docs/identity-services-engine/#!searching-a-resource/paging

# most calls can have filters applied

?filter=name.STARTW.a&filter=identityGroup.EQ.Finance

EQ Equals

NEQ Not Equals

GT Greater Than

LT Less Then

STARTSW Starts With

NSTARTSW Not Starts With

ENDSW Ends With

NENDSW Not Ends With

CONTAINS Contains

NCONTAINS Not Contains

# use filters to narrow devices by subnet?

In [48]: r = c.get("/ers/config/networkdevice?filter=ipaddress.STARTSW.10.100").json()
