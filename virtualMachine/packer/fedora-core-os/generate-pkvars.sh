#!/bin/bash

set -e

RELEASE_STREAMS=$1

mkdir -p ./build-source/etc
curl -s https://builds.coreos.fedoraproject.org/streams/${RELEASE_STREAMS}.json > ./build-source/etc/fcos-${RELEASE_STREAMS}.json

iso_url=$(cat ./build-source/etc/fcos-${RELEASE_STREAMS}.json | jq -r '.architectures.x86_64.artifacts.virtualbox.formats.ova.disk.location')
iso_signature=$(cat ./build-source/etc/fcos-${RELEASE_STREAMS}.json | jq -r '.architectures.x86_64.artifacts.virtualbox.formats.ova.disk.signature')
iso_sha256=$(cat ./build-source/etc/fcos-${RELEASE_STREAMS}.json | jq -r '.architectures.x86_64.artifacts.virtualbox.formats.ova.disk.sha256')
iso_sha256="sha256:${iso_sha256}"

# prevent export to the shell using a subshell
(
    export iso_url iso_signature iso_sha256 ssh_username ssh_password
    envsubst < ./build-source/etc/fcos.pkrvars.hcl.template > fcos.pkrvars.hcl
)

