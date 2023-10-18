# run adhoc commands

`ansible -m shell -a 'ls -loh /home/builder/.vimrc' 'az_agents[0]'`

`az_agents[0]` is a inventory filter

# filers

remove_keys - removes keys from nested dict

`{{ data_dict_or_list_of_dicts | remove_keys(target=['test_key', 'test_key2']) }}`
