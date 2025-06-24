# TEST YOURSELF: Understand API Deprecations

## Prepare

**This section is set up to work with Kubernetes 1.33 _only_. If you would like to set it up to work with a different Kubernetes version, see the note at the end of this section.**

1. Log in to your Kubernetes controller.

2. Add the `setup.sh` script to your controller's home directory as a non-root user.

3. Run the script:

```
chmod +x setup.sh
sudo ./setup.sh
```

> Uncomfortable running the script? No problem! Perform these actions:
> 1. Open `/etc/kubernetes/manifests/kube-apiserver.yaml`
> 2. Update the runtime config: `--runtime-config=networking.k8s.io/v1beta1`

> Not using Kubernetes 1.33? Look for an API that has a `beta` version in the API reference for your chosen version of Kubernetes and add it to you API configuration: `https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.33`
> 
> Adjust the following exercise accordingly.

## Tasks

1. Locate which API group `Ingress` is part of.

2. View which APIs have unstable versions enabled.

3. View which resources are governed by these APIs.

4. Confirm the perferred API version for the API(s) with alpha or beta versions.

5. Remove any unstable API versions from the Kubernetes Control Plane.

6. Confirm no unstable API versions are available.

## Solutions

**1. Locate which API group `Ingress` is part of.**

```
kubectl explain Ingress
```

**2. View which APIs have unstable versions enabled.**

```
kubectl api-versions
kubectl api-versions | grep -E 'alpha|beta'
```

**3. View which resources are governed by these APIs.**

```
kubectl api-resources --api-group=networking.k8s.io
```

**4. Confirm the perferred API version for the API(s) with alpha or beta versions.**

```
kubectl proxy 8001 &
curl http://localhost:8001/apis/networking.k8s.io
```

**5. Remove any unstable API versions from the Kubernetes Control Plane.**

Working from the Kubernetes Control Plane:

```
sudo vim /etc/kubernetes/manifests/kube-apiserver.yaml
```

Delete the following line:

```
- --runtime-config=networking.k8s.io/v1beta1
```

Save and exit. Wait for the server to restart.

**6. Confirm no unstable API versions are available.**

```
kubectl api-versions | grep -E 'alpha|beta'
```

This command should not output anything.
