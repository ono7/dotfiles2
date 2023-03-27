## install fish from apt install fish

* home osx $PATH

/Users/jlima/.virtualenvs/prod3/bin /Users/jlima/.npm-packages/bin /usr/local/opt/fzf/bin /usr/local
/bin /usr/bin /bin /usr/sbin /sbin /Users/jlima/.npm-packages/bin

* permanently add fish paths, do not add them to config.fish or recursion will
  occur every time a shell spawns

    * paths (append -Ua)
    set -Ua fish_user_paths ~/bin

remove path

```bash
env ❯ echo $fish_user_paths

/Users/jose.lima/Library/Python/3.7/bin /Users/jose.lima/bin /usr/local/Cellar/fzf/0.18.0/bin

venv ❯ set -e fish_user_paths[1]
venv ❯ echo $fish_user_paths
/Users/jose.lima/bin /usr/local/Cellar/fzf/0.18.0/bin
```


    * editor
    set -Ux EDITOR nvim

## rename files in directory
for i in *.txt
    mv $i (basename $i .txt).org
end


* functions

  loop to generate random numbers (src ports)

  for i in (seq 1 20)
      echo sh ip cef exact-route 10.31.115.141 src-port (random 1 65535) 10.255.76.235 dest-port 443
  end
