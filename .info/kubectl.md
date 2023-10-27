# commands

- `kubectl describe pods <name>`
- `kubectl get po -A` - same as kubectl get pods -A (-A: all namespaces)
- `kubectl api-resources` will list all the resources in the cluster
- `kubectl explain type` pulls information about the resouce, including human readable help
- `kubectl explain type --recursive` expand help for all resources and its children
- `kubectl explain node.spec` you can use 'dot, .' to traverse the help further down the tree
- `kubectl get pods -n kube-system` get all pods from the kube-system namespace
- `kubectl get all` get all running pods

- `kubectl run pingpong --image alpine ping 1.1.1.1` creating a (single) pod, run
  is an old command, create should be used in newer versions of k8s 1.18+

- `kubectl create deployment pingpong --image alpine -- ping 1.1.1.1` create a
  deployment with version 1.18+ the `--` separates the kubectl options with the
  command we want to override in the container.

- `kubectl create deployment --help`

- `kubectl scale deployment pingpong --replicas 3` scale the pingpong deployment
  from 1 replica to 3

- `kubectl scale deploy/pingpong --replicas 3` same as above, in short hand

## kubectl expose

exposing services to the outside

- `kubectl expose deployment httpenv --port 8888` this is using "deployment" as a
  `selector` to expose the services of each pod on port 8888

  `kubectl get service` check the status of the exposed service

  ```
  $ kubectl get service
  NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
  kubernetes   ClusterIP   10.152.183.1    <none>        443/TCP    23h
  httpenv      ClusterIP   10.152.183.40   <none>        8888/TCP   41s
  ```

## view logs

- `kubectl logs deploy/pingpong --tail 1 --follow` stream logs from a
  deployment, the pod is randomly picked

- `kubectl logs -l deploy/pingpong --tail 1 --follow` stream logs from a
  deployment, from upto 5 pods at the same time

- `kubectl logs -l deploy/pingpong --tail 1 --follow --max-log-requests 8` stream logs from a
  deployment, from more than 5 pods (8)

- `kubectl logs --tail 1 -f pod/pingpong-6d6ff8754d-8kk6d` get logs from
  specific deploymment pod `kubectl get all` will show all the pods available
  in a deployment

** better tool to use is `stern` **

```go
// abstration of layers that run when the run command is called
{ deployment {
    replica-set {
        pod {
            container { ping 1.1.1.1 }
          }
      }
  }
}
```

## creating resources

- `kubectl run abc` quickway to deploythings (old way of doing things), versatile
- `kubectl create` lacks features, cannot create cronjob in 1.14+, cant pass
  command line arguments to deployments
- `kubectl create -f mydeploy.yml` ( same as below, but very declerative), cant
- `kubectl apply -f mydeploy.yml` (same as above), all features are availible
  requires writing them in yaml

## common flags

`-n` --namespace
`-A` --all-namespace

## sesource names

most common resources have 3 types of names

`short` po = pod
`singular` pod, service, deployment
`plural` pod, service, deployments
