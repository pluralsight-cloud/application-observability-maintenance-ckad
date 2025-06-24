# TEST YOURSELF: Implement Probes and Health Checks

## Tasks

Using the `registry.k8s.io/echoserver:1.10` image, create a new deployment, `web-health-deployment` in `web-health.yaml`. Using the provided endpoint, create readiness and liveness probes.

The readiness probe should run after an initial 5 seconds and can fail up to 3 times, whereas the liveness prode should run every 10 seconds.

Deploy the deployment. Ensure the pod is in a **ready** state with no restarts.

## Solution

**Using the `registry.k8s.io/echoserver:1.10` image, create a new deployment, `web-health-deployment` in `web-health.yaml`.**

To generate a deployment skeleton, use `kubectl create deployment`, ensuring the deployment name is `web-health-deployment`, the `registry.k8s.io/echoserver` image is used, the output is YAML, and ensure the deployment is only simulated, not created. Output it into the `web-health.yaml` file.

```
kubectl create deploy web-health-deployment --image=web-health:latest -o yaml --dry-run=client > web-health.yaml
```

**Using the provided endpoint, create readiness and liveness probes.

The readiness probe should run after an initial 5 seconds and can fail up to 3 times, whereas the liveness prode should run every 10 seconds.**

Open the `web-health.yaml` file:

```
$EDITOR web-health.yaml
```

Under `containers`, add a readiness probe following the given parameters:

```
readinessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 5
  failureThreshold: 3

```

Under this, add the liveness probe:

```
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  periodSeconds: 10
```

**Deploy the deployment. Ensure the pod is in a ready state with no restarts.**

Deploy:

```
kubectl apply -f web-health.yaml
```

Run `kubectl get pods` until the pod is shown as ready:

```
kubectl get pods
```

Further confirm there were no errors:

```
kubectl describe pod <POD_NAME>
```

## Cleanup

Remove the deployment:

```
kubectl delete deploy web-health-deployment
```
