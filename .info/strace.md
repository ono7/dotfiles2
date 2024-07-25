## show what the process is reading and writing to

for example if a python process (ansible) is running in the background and we
dont know what its doing we can tap into it with strace to figure out what is
happening

`sudo strace -e read -p 3574` - Shows external output (router output or command output)
`sudo strace -e write -p 3574` - shows what the process is writing
