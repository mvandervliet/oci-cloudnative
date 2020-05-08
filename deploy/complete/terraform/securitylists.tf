# Copyright (c) 2020 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

resource oci_core_security_list oke-mushop_security_list {
  compartment_id = var.compartment_ocid
  display_name   = "oke-mushop_wkr_seclist-${random_string.deploy_id.result}"
  vcn_id         = oci_core_virtual_network.oke-mushop_vcn.id

  egress_security_rules {
    destination      = lookup(var.network_cidrs, "SUBNET-REGIONAL-CIDR")
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = true
  }

  egress_security_rules {
    destination      = lookup(var.network_cidrs, "ALL-CIDR")
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = false
  }

  ingress_security_rules {
    source      = lookup(var.network_cidrs, "SUBNET-REGIONAL-CIDR")
    source_type = "CIDR_BLOCK"
    protocol    = "all"
    stateless   = true
  }

  ingress_security_rules {
    source      = lookup(var.network_cidrs, "VCN-CIDR") # "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    stateless   = false

    tcp_options {
      max = "22"
      min = "22"
    }
  }

}

resource oci_core_security_list oke-mushop_lb_security_list {
  compartment_id = var.compartment_ocid
  display_name   = "oke-mushop_wkr_lb_seclist-${random_string.deploy_id.result}"
  vcn_id         = oci_core_virtual_network.oke-mushop_vcn.id

  egress_security_rules {
    destination      = lookup(var.network_cidrs, "ALL-CIDR")
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = true
  }

  ingress_security_rules {
    source      = lookup(var.network_cidrs, "ALL-CIDR")
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    stateless   = true
  }
}
