#### Helm
- Running HELM locally <https://blog.giantswarm.io/what-you-yaml-is-what-you-get/>

#### Create `kubeconfig` for ServiceAccount 
- `kubectl get serviceAccounts --all-namespaces`
- `kubectl describe secrets default-token...`
- `kubectl config view --flatten --minify`
    ```
    apiVersion: v1
    kind: Config
    users:
    - name: username
      user:
        # from `kubectl describe secrets default-token...`
        token:
    clusters:
    - cluster:
        # from `kubectl config view --flatten --minify`
        certificate-authority-data:
        server:
      name: cluster-name
    contexts:
    - context:
        cluster: cluster-name
        user: username
      name: cluster-context
    current-context: cluster-context
    ```


