# Rook

Thanks to [@darpanmalhotra for this post](https://medium.com/@darpanmalhotra/persistent-storage-solution-for-on-premises-kubernetes-clusters-72c676d6560e)

All file are copy past from example git repo [rook/rook](https://github.com/rook/rook/tree/master)

Version used: 1.13.1

Namespace is not required. A namespace called rook-ceph is auto created

```sh 
kubectl apply -f 00_crds.yaml

kubectl apply -f 01_common.yaml

kubectl apply -f 02_operator.yaml

kubectl apply -f 03_cluster.yaml

kubectl apply -f 04_storageclass.yaml
```
