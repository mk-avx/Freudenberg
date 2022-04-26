azure_firenet = {
  east1 = {
    region               = "East US"
    account              = "avx-ps"
    aws_transit_name     = "AvxFirenet"
    cidr                 = "10.100.0.0/16"
    instance_size        = "Standard_D3_v2"
    fw_instance_size     = "Standard_D3_v2"
    insane_mode          = "true"
    insane_instance_size = "Standard_D3_v2"
    az_support           = "true"
  }
}
gw_data = {
  dev = {
    account   = "avx-ps"
    vpc_id    = "azure-test-vnet:rg-av-azure-test-vnet-649871:fe3c61d3-5cdc-4ba2-b70b-4f6869bd86bb" #VNET ID, for using an existing VNET. Format is: "<\vnet_name>:<resource_group_name\>"
    region    = "East US"
    gw_size   = "Standard_D3_v2" #"Standard_B2ms"
    subnet    = "10.99.16.0/20"
    ha_subnet = "10.99.16.0/20"
    #eip              = "52.73.120.87"
    #ha_eip           = "35.173.46.191"
    gw_name          = "test-spoke"
    ha               = true
    hpe              = false
    allocate_new_eip = true
    #vpc_cidr         = "10.0.0.0/16" #needed to create the snat entry
    #transit = "avx-hsr-east2-firenet"
    az1        = "az-1"
    az2        = "az-2"
    az_support = true
  }
  /*
  uat = {
    account   = "avxacc"
    vpc_id    = "vpc-09a22c274c6464371"
    region    = "us-east-2"
    gw_size   = "t3.small"
    subnet    = "10.28.48.0/20"
    ha_subnet = "10.28.64.0/20"
    #eip         = "52.73.120.87"
    #ha_eip      = "35.173.46.191"
    gw_name          = "test-spoke-2"
    ha               = true
    hpe              = false
    allocate_new_eip = true
    vpc_cidr         = "10.28.0.0/16"
    transit          = "avx-ptml-west2-transit"
    #enable_private_vpc_default_route = false
    enable_nat = false
  }
*/
}
