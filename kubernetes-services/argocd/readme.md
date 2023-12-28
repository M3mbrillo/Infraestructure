# ArgoCD


Quick install from website [Argo CD - Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)

```sh
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Nginx-Ingress

To allow external access via ingress, apply [argocd-ingress.yaml](/argocd-ingress.yaml)

```sh
kubectl apply -n argocd -f argocd-ingress.yaml
```

Remember add `--enable-ssl-passthrough` to ingress-nginx-controller (deamon set).

More info: (Argocd: kubernetes ingress-nginx)[https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#kubernetesingress-nginx]