#
# VMs de testes
#

terraform {
  required_version = ">= 0.13.4"
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }
}

provider "vsphere" {
  user                 = "administrator@vsphere.local"
  password             = "VMware1!"
  vsphere_server       = "vcenter.vsphere.lab"
  allow_unverified_ssl = true
  api_timeout          = 10
}

module "vm-iac-001" {
  source  = "Terraform-VMWare-Modules/vm/vsphere"
  version = "3.8.0"

  dc                = "dc-lab"
  vmrp              = "cls-lab-drs/Resources"
  vmfolder          = "tenant01"
  datastore_cluster = "dcs-iscsi"
  vmtemp            = "template-linux-base"
  instances         = 1
  staticvmname      = "vm-iac-001"
  domain            = "vsphere.lab"
  ipv4submask       = ["24"]
  network = {
    "dpg-app" = ["172.16.207.91"]
  }
  dns_server_list = ["172.16.100.11"]
  vmgateway       = "172.16.207.1"

  tags = {
    "Tenant"    = "tenant01"
    "Priority"  = "high"
    "Relevance" = "essential"
  }
}

module "vm-iac-002" {
  source  = "Terraform-VMWare-Modules/vm/vsphere"
  version = "3.8.0"

  dc                = "dc-lab"
  vmrp              = "cls-lab-drs/Resources"
  vmfolder          = "tenant02"
  datastore_cluster = "dcs-iscsi"
  vmtemp            = "template-linux-base"
  instances         = 1
  staticvmname      = "vm-iac-002"
  domain            = "vsphere.lab"
  ipv4submask       = ["24"]
  network = {
    "dpg-app" = ["172.16.207.92"]
  }
  dns_server_list = ["172.16.100.11"]
  vmgateway       = "172.16.207.1"

  tags = {
    "Tenant"    = "tenant02"
    "Priority"  = "low"
    "Relevance" = "best-effort"
  }
}