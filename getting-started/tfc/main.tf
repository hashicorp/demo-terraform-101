// terraform {
//   backend "remote" {
//     organization = "my-organization"
//     workspaces {
//       name = "random-pet-demo"
//     }
//   }
// }

variable "stage" {
  default = "production"
}

resource "random_pet" "server" {
  keepers = {
    # Generate a new pet name each time we switch to a new stage
    stage = "${var.stage}"
  }
}

output "random_server_id" {
  value = random_pet.server.id
}
