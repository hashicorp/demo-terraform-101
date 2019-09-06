# lab_2_terraform_cloud_demo/write_state/main.tf
terraform {
  backend "remote" {
    organization = "<ORGANIZATION NAME>"

    workspaces {
      name = "terraform_cloud_write_state"
    }
  }
}


resource "random_id" "random" {
  keepers = {
    uuid = uuid()
  }

  byte_length = 8
}

output "random" {
  value = random_id.random.hex
}
