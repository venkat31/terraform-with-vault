terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.54.0"
    }
    oci = {
      source = "oracle/oci"
      version = "4.107.0"
    }
  }
  provider "vault" {
    address = "http://34.218.222.131:8200"
    skip_child_token = true

    auth_login {
      path = "auth/approle/login"

      parameters = {
        role_id = "ca4843d9-347f-3c9a-8df8-d47fb049f034"
        secret_id = "207b42f7-4e1d-fa52-df8d-fa93aa2d0872"
      }
    }
  }
}