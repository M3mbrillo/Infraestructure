packer {
    required_plugins {
        virtualbox = {
          version = "~> 1"
          source  = "github.com/hashicorp/virtualbox"
        }
    }
}

variable "vm_name" {
  type = string
  default="node-00 Fedora Core OS"
}

variable "iso_url" {
  type = string
}

variable "iso_signature" {
  type = string
}

variable "iso_sha256" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "ssh_private_key_file" {
  type = string
  sensitive = true
}

variable "ram_memory" {
  type = string
  default = "2048" 
}

variable "cpus" {
  type = string
  default="2"
}

variable "disk_size" {
  type = string
  default="10000"
}

variable "natnet_name" {
  type = string
  default="fcos-network"
}

variable "remote_config_ignition" {
  type = string
  default="https://github.com/M3mbrillo/Infraestructure/blob/main/virtualMachine/packer/fedora-core-os/build-source/http/config.ign"
}

locals {
  http_directory = "${path.root}/http"
}

source "virtualbox-iso" "fedora-core-os" {
  guest_os_type = "Fedora_64"
  iso_url = var.iso_url
  iso_checksum = var.iso_sha256

  vm_name = var.vm_name
  disk_size = var.disk_size
  vboxmanage =[
    ["modifyvm", "{{.Name}}", "--memory", var.ram_memory],
    ["modifyvm", "{{.Name}}", "--cpus", var.cpus],
    ["modifyvm", "{{.Name}}", "--vram", "128"],
    
    ["modifyvm", "{{.Name}}", "--nic1", "nat"],

    # ["modifyvm", "{{.Name}}", "--nat-network2", var.natnet_name],
    # ["modifyvm", "{{.Name}}", "--nic2", "natnetwork"],
  ]



  boot_command = ["curl -LO ${var.remote_config_ignition} <enter><wait>", "sudo coreos-installer install /dev/sda --ignition-file config.ign && sudo reboot<enter>", "<wait50m>"]
  boot_wait = "45s"

  ssh_username = var.ssh_username  
  ssh_private_key_file = var.ssh_private_key_file

  shutdown_command = "echo 'good bye UwU' | sudo -S shutdown -P now"
}

build {
  sources = ["sources.virtualbox-iso.fedora-core-os"]
}