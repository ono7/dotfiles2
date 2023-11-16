# list open files (lsof)

- show processes, `-nP` no dns and no port-name resolution

  ```sudo lsof -nP -iTCP:2222

  COMMAND PID USER FD TYPE DEVICE SIZE/OFF NODE NAME
  sshd 11846 myuser 9u IPv6 0xd606af2a62e750f7 0t0 TCP [::1]:2222 (LISTEN)
  sshd 11846 myuser 11u IPv4 0xd606af33f6aba9b7 0t0 TCP 127.0.0.1:2222 (LISTEN)
  ```

- show list of open files by pid
  `lsof -p <process_id>`
- list pid using network port 2222
  `-t = terse listing`
  `-i = selecp py ip address :2222, filter by port 222 (returns pid using port 222)`
  `lsof -t i:2222`

```

```
