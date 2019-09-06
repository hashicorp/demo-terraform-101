terraform {
  backend "remote" {
    organization = "<ORGANIZATION NAME>"

    workspaces {
      name = "terraform_cloud_read_state"
    }
  }
}

resource "random_id" "random" {
  keepers = {
    uuid = uuid()
  }

  byte_length = 8
}

data "terraform_remote_state" "write_state" {
  backend = "remote"

  config = {
    organization = "<ORGANIZATION NAME>"

    workspaces = {
      name = "terraform_cloud_write_state"
    }
  }
}
