#!/bin/bash

set -euo pipefail

MANIFEST_PATH="/etc/kubernetes/manifests/kube-apiserver.yaml"
API_CONFIG="--runtime-config=networking.k8s.io/v1beta1"

echo "[INFO] Backing up the API server manifest..."
cp "$MANIFEST_PATH" /tmp/kube-apiserver.yaml.bak

echo "[INFO] Updating runtime-config to enable networking.k8s.io/v1beta1 only..."

# Remove any existing --runtime-config line, then add the correct one
if grep -q -- '--runtime-config' "$MANIFEST_PATH"; then
  sed -i "/--runtime-config/d" "$MANIFEST_PATH"
fi

# Insert the correct runtime-config line
sed -i "/- kube-apiserver/a \    - $API_CONFIG" "$MANIFEST_PATH"

echo "[INFO] kube-apiserver manifest updated. Waiting for Kubernetes API to restart..."

until kubectl --kubeconfig=/etc/kubernetes/admin.conf get nodes &>/dev/null; do
  echo "[INFO] Waiting for Kubernetes API server..."
  sleep 5
done

echo "[SUCCESS]"
