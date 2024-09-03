#!/bin/bash

# ./extract-secrects.sh [cluster_name] [user_name]

# Inspirado en  https://github.com/systemcraftsman/strimzi-kafka-cli/tree/main/examples/2_tls_authentication


cluster_name=$1
user_name=$2

# Secrects / certificate del cluster
mkdir -p ./cert-tls/cluster
# Secret with the Cluster CA public key. This key can be used to verify the identity of the Kafka brokers.
kubectl get secret ${cluster_name}-cluster-ca-cert -o jsonpath='{.data.ca\.crt}' -n kafka | base64 -d > ./cert-tls/cluster/${cluster_name}-cluster-ca-cert.crt
kubectl get secret ${cluster_name}-cluster-ca-cert -o jsonpath='{.data.ca\.p12}' -n kafka | base64 -d > ./cert-tls/cluster/${cluster_name}-cluster-ca-cert.p12
kubectl get secret ${cluster_name}-cluster-ca-cert -o jsonpath='{.data.ca\.password}' -n kafka | base64 -d > ./cert-tls/cluster/${cluster_name}-cluster-ca-cert.password
# Secret with the Cluster CA private key used to encrypt the cluster communication
kubectl get secret ${cluster_name}-cluster-ca -o jsonpath='{.data.ca\.key}' -n kafka | base64 -d > ./cert-tls/cluster/${cluster_name}-cluster-ca.key



# Secrects / Certificate cluster-client
mkdir -p ./cert-tls/cluster-client
# Secret with the Clients CA public key. This key can be used to verify the identity of the Kafka users.
kubectl get secret ${cluster_name}-clients-ca-cert -o jsonpath='{.data.ca\.crt}' -n kafka | base64 -d > ./cert-tls/cluster-client/${cluster_name}-clients-ca-cert.crt
kubectl get secret ${cluster_name}-clients-ca-cert -o jsonpath='{.data.ca\.p12}' -n kafka | base64 -d > ./cert-tls/cluster-client/${cluster_name}-clients-ca-cert.p12
kubectl get secret ${cluster_name}-clients-ca-cert -o jsonpath='{.data.ca\.password}' -n kafka | base64 -d > ./cert-tls/cluster-client/${cluster_name}-clients-ca-cert.password
# Secret with the Clients CA private key used to sign user certificates
kubectl get secret ${cluster_name}-clients-ca -o jsonpath='{.data.ca\.key}' -n kafka | base64 -d > ./cert-tls/cluster-client/${cluster_name}-clients-ca.key



# Secrects / certificate de un usuario
mkdir -p ./cert-tls/user/
kubectl get secret ${user_name} -o jsonpath='{.data.ca\.crt}' -n kafka | base64 -d > ./cert-tls/user/${user_name}-ca.crt
kubectl get secret ${user_name} -o jsonpath='{.data.user\.crt}' -n kafka | base64 -d > ./cert-tls/user/${user_name}-user.crt
kubectl get secret ${user_name} -o jsonpath='{.data.user\.key}' -n kafka | base64 -d > ./cert-tls/user/${user_name}-user.key
kubectl get secret ${user_name} -o jsonpath='{.data.user\.p12}' -n kafka | base64 -d > ./cert-tls/user/${user_name}-user.p12
kubectl get secret ${user_name} -o jsonpath='{.data.user\.password}' -n kafka | base64 -d > ./cert-tls/user/${user_name}-user.password

# Convert .p12 to jks with a simple password 123456
SRC_STORE_PASS=$(cat ./cert-tls/user/${user_name}-user.password) && \
keytool -importkeystore \
    -srckeystore ./cert-tls/user/${user_name}-user.p12 \
    -srcstorepass ${SRC_STORE_PASS} \
    -srcstoretype pkcs12 \
    -srcalias ${user_name} \
    -destkeystore ./cert-tls/user.jks \
    -deststoretype jks \
    -deststorepass 123456 \
    -destalias ${user_name} 1> /dev/null

# Generate the truststore...
echo "yes" | keytool -import \
    -trustcacerts \
    -file ./cert-tls/cluster/${cluster_name}-cluster-ca-cert.crt \
    -keystore ./cert-tls/truststore-cluster-ca-cert.jks \
    -storepass 123456 1> /dev/null

printf "\n./cert-tls/user/${user_name}-user.password: ${SRC_STORE_PASS}"
