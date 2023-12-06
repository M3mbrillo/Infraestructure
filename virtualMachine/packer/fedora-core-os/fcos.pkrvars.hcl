iso_url="https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/38.20230902.3.0/x86_64/fedora-coreos-38.20230902.3.0-live.x86_64.iso"
iso_signature="https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/38.20230902.3.0/x86_64/fedora-coreos-38.20230902.3.0-live.x86_64.iso.sig"
iso_sha256="sha256:bc972cdee047113ed2af3a68c9b18d0f8a6fd12ddc87d6d030a7e10061c07ea4"


ssh_username="core"
ssh_private_key_file="build-source/ssh-keypar/user-fcos"

ram_memory="2048"
cpus="2"
disk_size="10000"

natnet_name="microk8s-cluster"

remote_config_ignition="https://raw.githubusercontent.com/M3mbrillo/Infraestructure/main/virtualMachine/packer/fedora-core-os/build-source/http/config.ign"