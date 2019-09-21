#### Consul Installation #1
- <https://medium.com/@amimahloof/vault-consul-high-availability-end-to-end-tls-on-kubernetes-9c02fff2be2e>
- Install `go`
- 
- GOSSIP_ENCRYPTION_KEY=$(consul keygen)  "oAos8ArgEGoBjVfc2kscFA=="
- kubectl create secret generic consul \
    --from-literal="gossip-encryption-key=${GOSSIP_ENCRYPTION_KEY}" \
    --from-file=ca.pem \
    --from-file=consul.pem \
    --from-file=consul-key.pem
- kubectl create -f statefulsets/consul.yaml
    

#### Consul Installation #2
```
git clone https://github.com/hashicorp/consul-helm.git
cd consul-helm
git checkout v0.9.0

helm install \
# helm template --output-dir ./output \
  --name consul \
  --namespace kube-system \
  ./

```


#### Vault Installation
```
git clone https://github.com/hashicorp/vault-helm
cd vault-helm
git checkout v0.1.2

# helm template --output-dir ./output \
helm install \
  --name vault \
  --set server.ha.enabled=true \
  --namespace kube-system \
  ./
```

#### Links
- <https://www.hashicorp.com/blog/announcing-the-vault-helm-chart>
- <https://www.vaultproject.io/docs/platform/k8s/run.html>
- <https://www.vaultproject.io/docs/platform/k8s/helm.html>
- <https://github.com/Boostport/kubernetes-vault>
