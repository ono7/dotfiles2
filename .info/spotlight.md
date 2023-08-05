# shows current files being index, useful if things slow down

sudo fs_usage -w -f filesys mds_stores

# rebuild spotlight cache/index, this takes a while

sudo mdutil -E /
