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
