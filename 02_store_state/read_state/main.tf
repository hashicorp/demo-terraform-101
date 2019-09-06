terraform {
  backend "remote" {
    organization = "<ORGANIZATION NAME>"

    workspaces {
      name = "lab_2_read_state"
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
      name = "lab_2_write_state"
    }
  }
}
