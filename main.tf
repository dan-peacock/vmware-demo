terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}

provider "vsphere" { 
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.dc_name
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1 (1)"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = "Henlow"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "AELTC-TF"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  guest_id         = "other3xLinux64Guest"
  wait_for_guest_net_timeout = 0
  # wait_for_guest_net_routable = false
  memory           = 1024
  network_interface {
    network_id = data.vsphere_network.network.id
  }
    disk {
    label = "aeltc-tf-disk"
    size  = 5
  }
}