# TEST YOURSELF - Utilize Container Logs

## Prepare

Create the pod for this exercise:

```
kubectl create -f eventful-app.yaml
```

## Tasks

A pod is experiencing intermittent errors. Using container logs, view the last ten logs.

Additionally, view the logs from the last ten minutes.

Finally, follow the logs live.

Remove the pod.

## Solution

**A pod is experiencing intermittent errors. Using container logs, view the last ten logs.**

Confirm the `eventful-app` pod is running:

```
kubectl get pods
```

Use `--tail` to view the last ten lines of logs:

```
kubectl logs --tail=10 eventful-app
```

**Additionally, view the logs from the last ten minutes.**

Use `--since` to view the logs from the last ten minutes:

```
kubectl logs --since=10m eventful-app
```

**Finally, follow the logs live.**

Use the `-f` flag to follow the logs live:

```
kubectl logs -f eventful-app
```

Hit **CTRL-C** to stop following the logs.

**Remove the pod.**

```
kubectl delete pod eventful-app
```
