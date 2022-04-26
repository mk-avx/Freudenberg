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
/*
resource "aviatrix_transit_external_device_conn" "Transit_FW" {
  vpc_id            = module.transit_firenet_1.vnet
  connection_name   = "my_conn"
  gw_name           = "transitGw"
  connection_type   = "bgp"
  bgp_local_as_num  = "123"
  bgp_remote_as_num = "345"
  remote_gateway_ip = "172.12.13.14"
}*/

resource "aviatrix_spoke_gateway" "spoke_gateway_azure" {
  for_each                          = var.gw_data
  cloud_type                        = 8
  account_name                      = each.value.account
  gw_name                           = each.value.gw_name
  vpc_id                            = each.value.vpc_id
  vpc_reg                           = each.value.region
  gw_size                           = each.value.gw_size
  subnet                            = each.value.subnet
  eip                               = each.value.allocate_new_eip ? null : each.value.eip
  single_ip_snat                    = false
  enable_active_mesh                = true
  manage_transit_gateway_attachment = false
  ha_gw_size                        = each.value.ha ? each.value.gw_size : null
  ha_subnet                         = each.value.ha ? each.value.ha_subnet : null
  ha_eip                            = each.value.allocate_new_eip ? null : (each.value.ha ? each.value.ha_eip : null)
  #insane_mode_az                    = each.value.hpe ?  : null
  #ha_insane_mode_az                 = each.value.ha ? (each.value.hpe ? data.aws_availability_zones.az_available.names[1] : null) : null
  insane_mode      = each.value.hpe
  allocate_new_eip = each.value.allocate_new_eip
  #enable_private_vpc_default_route  = each.value.enable_nat ? each.value.enable_private_vpc_default_route : null
  zone    = each.value.az_support ? each.value.az1 : null
  ha_zone = each.value.ha ? (each.value.az_support ? each.value.az2 : null) : null


}

resource "aviatrix_spoke_transit_attachment" "spoke_attachment" {
  for_each        = var.gw_data
  spoke_gw_name   = aviatrix_spoke_gateway.spoke_gateway_azure[each.key].gw_name
  transit_gw_name = module.transit_firenet_1.transit_gateway.gw_name

}


#####testing infra #####

# Create an Azure VNet
resource "aviatrix_vpc" "azure_vnet" {
  cloud_type           = 8
  account_name         = "avx-ps"
  region               = "East US"
  name                 = "azure-test-vnet"
  cidr                 = "10.99.0.0/16"
  aviatrix_firenet_vpc = false
}
