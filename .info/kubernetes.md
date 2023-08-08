# k8s/kubernetes notes

https://kubernetes.io

rancher, kubernetes as a service

## master node components

-jcomponetes
`controller manager` - runs server workloads and processes
`etcd` - database used by k8 to store info about it self. this is a k,v store
`api server` - the front end exposed to the world
`scheduler` - control plane process that assignes resources on the nodes,
knows which resources have capacity

## worker node components

`kubelet` - main service, takes intructions from api server makes sure all
containers are healthy, reports status to master, does not make decicions only
executes them.

`kube-proxy` -

`pod` smallest entity in a k8 cluster and has containers

### k3s, lightweight version of k8s, can run on raspberrypi etc

## commands

- manage nodes
  `kubectl get nodes` - get information about nodes and their current state

- manage pods
  `kubectl get pods --all-namespaces` - returns all pods in all name spaces
  the `system` namespace is where k8 stores its internal components and should
  not be used.

- manage namespaces
  `kubectl create namespace webservers`
  `kubectl config set context webservers` (change default config context)

- running pods
  `kubectl run nginx --image nginx`

- get pod status
  `kubectl get pods -o wide` shows details about where things are running for the
  pod

- deploy new images/vms
  `kubectl apply -f deploy_server.yml` deploys a new server to the pods created

## other notes

edit the replicas property in the deployment yaml to increase the number of vms
deployed
