# download and untar at the same time

```sh
wget -qO- your_link_here | tar xvz
To specify a target directory:

wget -qO- your_link_here | tar xvz -C /target/directory
If you happen to have GNU tar, you can also rename the output dir:

wget -qO- your_link_here | tar --transform 's/^dbt2-0.37.50.3/dbt2/' -xvz
```
