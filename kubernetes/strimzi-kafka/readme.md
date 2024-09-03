
nginx controller: add args: --enable-ssl-passthrough


```sh
k apply -f kafka-cluster.yaml
k apply -f user.yaml

./extract-secrects.sh hoen-cluster professor-birch
```

example of configuration:

```conf
bootstrap.servers=bootstrap.kafka.rke2-queen:443
security.protocol=SSL
ssl.endpoint.identification.algorithm=
ssl.key.location=./cert-tls/user/professor-birch-user.key
ssl.certificate.location=./cert-tls/user/professor-birch-user.crt
ssl.ca.location=./cert-tls/cluster/hoen-cluster-cluster-ca-cert.crt
```


test configuration with kcat (https://github.com/edenhill/kcat)

```sh
kcat -L
```

Expected:
```
Metadata for all topics (from broker -1: ssl://bootstrap.kafka.rke2-queen:443/bootstrap):
 1 brokers:
  broker 0 at broker-0.kafka.rke2-queen:443 (controller)
 0 topics:
```