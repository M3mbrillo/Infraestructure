#!/bin/bash

# ./extract-user.sh [user_name]

# Inspirado en  https://github.com/systemcraftsman/strimzi-kafka-cli/tree/main/examples/2_tls_authentication

user_name=$1


# Secrects / certificate de un usuario
mkdir -p ./cert-tls/user-${user_name}/
kubectl get secret ${user_name} -o jsonpath='{.data.ca\.crt}' -n kafka | base64 -d > ./cert-tls/user-${user_name}/${user_name}-ca.crt
kubectl get secret ${user_name} -o jsonpath='{.data.user\.crt}' -n kafka | base64 -d > ./cert-tls/user-${user_name}/${user_name}-user.crt
kubectl get secret ${user_name} -o jsonpath='{.data.user\.key}' -n kafka | base64 -d > ./cert-tls/user-${user_name}/${user_name}-user.key
kubectl get secret ${user_name} -o jsonpath='{.data.user\.p12}' -n kafka | base64 -d > ./cert-tls/user-${user_name}/${user_name}-user.p12
kubectl get secret ${user_name} -o jsonpath='{.data.user\.password}' -n kafka | base64 -d > ./cert-tls/user-${user_name}/${user_name}-user.password

# Convert .p12 to jks with a simple password 123456
SRC_STORE_PASS=$(cat ./cert-tls/user-${user_name}/${user_name}-user.password) && \
keytool -importkeystore \
    -srckeystore ./cert-tls/user-${user_name}/${user_name}-user.p12 \
    -srcstorepass ${SRC_STORE_PASS} \
    -srcstoretype pkcs12 \
    -srcalias ${user_name} \
    -destkeystore ./cert-tls/user-${user_name}.jks \
    -deststoretype jks \
    -deststorepass 123456 \
    -destalias ${user_name} 1> /dev/null


printf "\n./cert-tls/user-${user_name}/${user_name}-user.password: ${SRC_STORE_PASS}"
