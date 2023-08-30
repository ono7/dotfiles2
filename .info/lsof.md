# list open files (lsof)

- show list of open files by pid
  `lsof -p <process_id>`
- list pid using network port 2222
  `-t = terse listing`
  `-i = selecp py ip address :2222, filter by port 222 (returns pid using port 222)`
  `lsof -t i:2222`
