# How to fix — Kubernetes namespace deleting stuck in Terminating state
```
kubectl get namespace logging -o json > namespace.json

Update:
"finalizers": []

kubectl replace --raw "/api/v1/namespaces/logging/finalize" -f ./namespace.json
```