```
kubectl proxy
kubectl get namespace nnn -o json > tmp.json
curl -k -H "Content-Type: application/json" -X PUT \
  --data-binary @tmp.json \
  http://127.0.0.1:8001/api/v1/namespaces/nnn/finalize
```