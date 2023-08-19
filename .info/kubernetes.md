# k8s/kubernetes notes

official docs - https://kubernetes.io
https://github.com/devopsjourney1/learn-k8s

rancher, kubernetes as a service

# use kubectl explain to get dataneeded to create apis

** discover schemas for any of the k8 apis by using kubectl explain command **

`kubectl explain configmap.data`

this will return the schema needed to build automation for configmap.data

## access containers in k8

`kubectl exec -it xyz-container-name bash`
this will log in to container xyz-container-name using bash interactively

## kubescape

scan for security concerns, can also scan repos and code as well as containers
it can be integrated into the CI pipeline

## gotchas

- `configuration maps in manifest` - treat them as mutable, once defined do not
  change them

```yml
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: myconfigmapv1.1 # change the version when making changes (myconfigmapv1.2)
data:
  BG_COLOR: "#12181b"
  FONT_COLOR: "#FFFFFF"
  CUSTOM_HEADER: "DevOps Journey - lima! config map change"
```

## components

- namespaces
- pods
  - group of containers that make up an application
- replication sets
- deployments
- config maps
- kubernetes manifest
- CoreDNS - the cluter's DNS service

- servers:
  - master node
    - Api server - front end kubectl talks to it
    - Schuduler
    - controllers
    - etcd - shared k,v store
  - worker nodes
    - Runtimes docker, etc
    - Kubelet takes work from the controllers to deploy
    - Kube-proxy handles network communications

## master node components

- componetes
  - `controller manager` runs server workloads and processes
  - `etcd` database used by k8 to store info about it self. this is a k,v store
  - `api server` the front end exposed to the world
  - `scheduler` control plane process that assignes resources on the nodes,
    knows which resources have capacity

## worker node components

- `kubelet` main service, takes intructions from api server makes sure all
  containers are healthy, reports status to master, does not make decicions only
  executes them.

- `kube-proxy`

- `pod` smallest entity in a k8 cluster and has containers

### k3s, lightweight version of k8s, can run on raspberrypi etc

## commands

- load balancer

  - `kubectl expose deployment example-node --type=LoadBalancer --port=8080 -n lab`
    expose service on namespace lab
  - `minikube service hello-node -n lab` show the service configured

- kubectl

  - `kubectl cluster-info` k8 cluster info
  - `kubectl get events -n prod` get all events for namespace prod

- manage nodes

  - `kubectl get nodes` get information about nodes and their current state
  - `kubectl describe -n awx pod awx-54696666c5-fn5pb` get info about a
  - `kubectl describe node xyz` particular vm running in a pod called awx

- manage pods

  - `kubectl get pods --all-namespaces` returns all pods in all name spaces
    the `system` namespace is where k8 stores its internal components and should
    not be used.
  - `kubectl get pods -n xyz` get the pods for namespace xyz

- manage namespaces

  - `kubectl create namespace webservers`
  - `kubectl config set context webservers` change default config context

- running pods

  - `kubectl run nginx --image nginx`

- get pod status

  - `kubectl get pods -o wide` shows details about where things are running for the
    pod

- deploy new images/vms
  - `kubectl apply -f deploy_server.yml` deploys a new server to the pods created

## other notes

edit the replicas property in the deployment yaml to increase the number of vms
deployed
