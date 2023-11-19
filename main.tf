provider "aws" {
  region     = "us-west-2"
  
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

resource "aws_vpc" "dev_vpc"{
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: "development"
  }
}

resource "aws_subnet" "dev_subnet1" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-west-2a"
  tags = {
    Name: "development-subnet1"
  }
}

provider "vault" {
  address = var.address
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = var.role_id
      secret_id = var.secret_id
    }
  }
}

resource "vault_approle_auth_backend_role" "app_role" {
  backend                 = "approle"
  role_name               = "terraform"
  secret_id_ttl           = "10m"
  token_num_uses          = 10
  token_ttl               = "20m"
  token_max_ttl           = "30m"
  secret_id_num_uses      = 40
  token_policies          = ["terraform"]
  secret_id_bound_cidrs   = ["0.0.0.0/0"]
}

resource "vault_policy" "terraform" {
  name        = "terraform"
  policy      = <<EOF
    path "*" {
        capabilities = ["list", "read"]
    }

    path "secrets/data/*" {
      capabilities = ["create", "read", "update", "delete", "list"]
    }

    path "kv/data/*" {
      capabilities = ["create", "read", "update", "delete", "list"]
    }

    path "secret/data/*" {
      capabilities = ["create", "read", "update", "delete", "list"]
    }

    path "auth/token/create" {
      capabilities = ["create", "read", "update", "list"]
    }
  EOF
}


data "vault_kv_secret_v2" "example" {
  mount = "keyvalue" // change it according to your mount
  name  = "my-secrets" // change it according to your secret
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
