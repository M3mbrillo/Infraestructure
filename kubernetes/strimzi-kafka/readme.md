
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

ssl.keystore.location=/home/m3mbrillo/source/_personal/Infraestructure/kubernetes/strimzi-kafka/cert-tls/user/professor-birch-user.p12
ssl.keystore.password=fT0AQz8oygZfk3gOF8B3TFJbPFE5yjh3

ssl.ca.location=/home/m3mbrillo/source/_personal/Infraestructure/kubernetes/strimzi-kafka/cert-tls/cluster/hoen-cluster-cluster-ca-cert.crt
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
 1 topics:
  topic "default-any-topic" with 1 partitions:
    partition 0, leader 0, replicas: 0, isrs: 0
```