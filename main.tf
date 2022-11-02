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
data "vsphere_host" "host" {
  name          = "ESXI-HASH01.homelab.local"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_compute_cluster" "compute_cluster" {
  name            = "terraform-compute-cluster-test"
  host_system_ids = [data.vsphere_host.host.id]
  datacenter_id   = data.vsphere_datacenter.datacenter.id
}