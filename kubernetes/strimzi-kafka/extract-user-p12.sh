#!/bin/sh

mkdir -p $2

kubectl get secrets $1 -o json | jq '.data["user.password"]' | tr -d '""' | base64 -d > $2/password.txt
kubectl get secrets $1 -o json | jq '.data["user.p12"]' | tr -d '""' | base64 -d > $2/privatekey.p12

echo "end extraction from current kafka cluster context: $1 -- output: $2"

