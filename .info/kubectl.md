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

- `kubectl logs deploy/pingpong --tail 1 --follow` stream logs from a
  deployment, the pod is randomly picked

- `kubectl logs --tail 1 -f pod/pingpong-6d6ff8754d-8kk6d` get logs from
  specific deploymment pod `kubectl get all` will show all the pods available
  in a deployment

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

## common flags

`-n` --namespace
`-A` --all-namespace

## sesource names

most common resources have 3 types of names

`short` po = pod
`singular` pod, service, deployment
`plural` pod, service, deployments
