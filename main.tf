module "transit_firenet_1" {
  source                 = "terraform-aviatrix-modules/azure-transit-firenet/aviatrix"
  version                = "4.0.3"
  cidr                   = var.azure_firenet.east1.cidr
  region                 = var.azure_firenet.east1.region
  account                = var.azure_firenet.east1.account
  firewall_image         = "Check Point CloudGuard IaaS Single Gateway R80.40 - Bring Your Own License"
  firewall_image_version = "8040.900294.0593"
  insane_instance_size   = var.azure_firenet.east1.insane_instance_size
  fw_instance_size       = var.azure_firenet.east1.fw_instance_size
  insane_mode            = var.azure_firenet.east1.insane_mode
  az_support             = var.azure_firenet.east1.az_support
}
