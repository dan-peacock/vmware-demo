module "tfplan-functions" {
    source = "policies/common-functions/tfplan-functions/tfplan-functions.sentinel"
}

module "tfstate-functions" {
    source = "policies/common-functions/tfstate-functions/tfstate-functions.sentinel"
}

module "tfconfig-functions" {
    source = "policies/common-functions/tfconfig-functions/tfconfig-functions.sentinel"
}

policy "restrict-vm-disk-size" {
    source = "policies/azure/restrict-vm-size.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict-vm-disk-size" {
    source = "policies/vmware/restrict-vm-disk-size.sentinel"
    enforcement_level = "hard-mandatory"
}