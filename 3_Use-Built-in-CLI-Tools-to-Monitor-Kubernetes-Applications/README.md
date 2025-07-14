# TEST YOURSELF - Use Built-in CLI Tools to Monitor Kubernetes Applications

## Prepare

Create the pod for this exercise (pod name will be hidden):

```
kubectl create -f pod.yaml >/dev/null 2>&1
```

## Tasks

A pod is using more CPU than expected. Deterimine the affected worker nodes and track down the CPU-intensive pod.

Create a RAW file of the metrics of the node under stress.

Remove the offending pod.

## Solution

**A pod is using more CPU than expected. Deterimine the affected worker nodes and track down the CPU-intensive pod.**

View the metrics data for the nodes:

```
kubectl top nodes
```

View the metrics data for pods. Note the name of the pod with high CPU usage.

```
kubectl top pods
```

**Create a RAW file of the metrics of the node under stress.**


```
kubectl top --raw /api/v1/nodes/<NODE_NAME>/proxy/metrics/resource > nodemetrics.txt
```

**Remove the offending pod.**

```
kubectl delete pod <POD_NAME>
```
