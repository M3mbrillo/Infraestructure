
pre-requisite:
enable passthrough nginx controller: edit ingress-nginx-controller

add: --enable-ssl-passthrough
```yaml
#more things...
      containers:
        - name: rke2-ingress-nginx-controller
          image: rancher/nginx-ingress-controller:v1.10.1-hardened1
          args:
            - /nginx-ingress-controller
            - '--election-id=rke2-ingress-nginx-leader'
            - '--controller-class=k8s.io/ingress-nginx'
            - '--ingress-class=nginx'
            - '--configmap=$(POD_NAMESPACE)/rke2-ingress-nginx-controller'
            - '--validating-webhook=:8443'
            - '--validating-webhook-certificate=/usr/local/certificates/cert'
            - '--validating-webhook-key=/usr/local/certificates/key'
            - '--enable-metrics=false'
            - '--enable-ssl-passthrough'
#more things...
```


Create a simple ephimeral cluster
```sh
k apply -f kafka-cluster.yaml
k apply -f user.yaml

./extract-secrects.sh hoen-cluster professor-birch
```

example of configuration to connect:

```conf
bootstrap.servers=bootstrap.kafka.rke2-queen:443
security.protocol=SSL
ssl.endpoint.identification.algorithm=

ssl.keystore.location=./cert-tls/user/professor-birch-user.p12
ssl.keystore.password=XXXXXXXXXXXx

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
 1 topics:
  topic "default-any-topic" with 1 partitions:
    partition 0, leader 0, replicas: 0, isrs: 0
```



Enable kafka bridge:

```sh
k apply -f kafka-bridge.yaml

# expose bridge through https 
k apply -f ingress-hoen-bridge.yaml

# dummy topics to test
k apply -f kafka-topic.yaml
```


Test kafka bridge:
```sh
curl --location 'https://bridge.kafka.rke2-queen/topics' --header 'Accept: application/vnd.kafka.v2+json'
```

Expected:
```json
[
    "default-first-topic",
    "default-second-topic"
]
```