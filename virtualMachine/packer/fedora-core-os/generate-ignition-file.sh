#!/bin/sh

mkdir -p ./build-source/http/
SSH_RSA=$(cat ./build-source/ssh-keypar/fcos-user.pub)
(
    export SSH_RSA
    envsubst < ./build-source/etc/config.bu.template > ./build-source/http/config.bu
)

cd ./build-source/http

docker run --interactive --rm --security-opt label=disable --volume ${PWD}:/pwd --workdir /pwd quay.io/coreos/butane:release --pretty --strict config.bu > config.ign