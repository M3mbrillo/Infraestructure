# Packer - Fedora Core OS

Create with packer a image of fedora core os (https://fedoraproject.org/en/coreos) ready to use on virtual box

## How to

. Generate a keypair o `./build-source/ssh-keypar` named `user-fcos` without passphrase
```sh
mkdir -p ./build-source/ssh-keypar
ssh-keygen -t rsa -f build-source/ssh-keypar/user-fcos
```

. Generate a Ignition file for Fedora Core OS.
```sh
./generate-ignition-file.sh
```

. Use the last version of Fedora Core OS. Run these command to generate the file `fcos.pkrvars.hcl` 

```sh
./generate-pkvars.sh [RELEASE_STREAMS]

# Avaible RELEASE_STREAMS:
# - stable
# - testing
# - next
```

. Packer init

```sh
packer init .
```

. Packer build

