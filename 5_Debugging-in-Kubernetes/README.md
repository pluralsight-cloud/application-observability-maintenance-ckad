# TEST YOURSELF - Utilize Container Logs

## Prepare

Create the pod for this exercise:

```
kubectl create -f nginx.yaml
```

## Tasks

A pod, `nginx`, is continuously falling into a failed state and restarting. Troubleshoot the pod to locate the source of the issue. Leverage a debug pod to check for any missing internal components.

Resolve the issue.

## Solution

**A pod, `nginx`, is continuously falling into a failed state and restarting. Troubleshoot the pod to locate the source of the issue. Leverage a debug pod to check for any missing internal components.**

Confirm that the pod is in a failing state:

```
kubectl get pods
```

Notice the `STATUS` and amount of restarts.

Use `kubectl describe` to view pod events:

```
kubectl describe pod nginx
```

Notice that the liveness and readiness probes are failing.

Review the logs:

```
kubectl logs nginx
```

It seems as though something is attempting to hit the `/health` endpoint and failing. Let's use a debug pod to confirm if the endpoint exists:

```
kubectl debug -it nginx --image=nginx --share-processes --copy-to=nginx-debug
```

You'll see some errors about the port already being in use, but those can be ignored. Additionally, node the name of the generated container. It should be `debugger` followed by some random characters.

Exec into the container:

```
kubectl exec -it nginx-debug -c <container_name> -- sh
```

Review the file contents at `usr/share/nginx/html` to check for a `health` endpoint

```
ls usr/share/nginx/html
```

The endpoint is missing! Exit out of the container.

```
exit
```

To resolve the issue, let's update the endpoint of the probes to look for `/` instead. Open the `nginx.yaml` file and adjust the manifest:

```
readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 3
  periodSeconds: 5
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 3
  periodSeconds: 5
```

Save and exit. Redeploy the pod:

```
kubectl delete pod nginx
kubectl apply -f nginx.yaml
```

Confirm that the pod is running:

```
kubectl get pods
```

## Cleanup

Remove the pod:

```
kubectl delete pod -f nginx.yaml
```
