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
#### EKS
- EKS ALB https://kubernetes-sigs.github.io/aws-alb-ingress-controller/guide/ingress/annotation/
- https://medium.com/faun/learning-kubernetes-by-doing-part-3-services-ed5bf7e2bc8e
- https://medium.com/@dmaas/amazon-eks-ingress-guide-8ec2ec940a70
- https://medium.com/@dmaas/setting-up-amazon-eks-what-you-must-know-9b9c39627fbc
- https://aws.amazon.com/blogs/opensource/kubernetes-ingress-aws-alb-ingress-controller/
- https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
- https://github.com/kubernetes-sigs/aws-alb-ingress-controller/issues/886
- https://medium.com/faun/learning-kubernetes-on-eks-by-doing-part-4-ingress-on-eks-6c5e5a34920b
- https://github.com/kubernetes-sigs/aws-alb-ingress-controller/blob/master/docs/guide/ingress/annotation.md
- https://kubernetes-sigs.github.io/aws-alb-ingress-controller/guide/tasks/ssl_redirect/
