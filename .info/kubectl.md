# commands

`kubectl describe pods <name>`
`kubectl get po -A` - same as kubectl get pods -A (-A: all namespaces)
`kubectl api-resources` will list all the resources in the cluster
`kubectl explain type` pulls information about the resouce, including human readable help
`kubectl explain type --recursive` expand help for all resources and its children
`kubectl explain node.spec` you can use 'dot, .' to traverse the help further down the tree
`kubectl get pods -n kube-system` get all pods from the kube-system namespace
`kubectl get all` get all running pods

## common flags

`-n` --namespace
`-A` --all-namespace

## sesource names

most common resources have 3 types of names

`short` po = pod
`singular` pod, service, deployment
`plural` pod, service, deployments
