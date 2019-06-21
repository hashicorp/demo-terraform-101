# Learn HashiCorp Terraform on GCP

## Install Terraform

### Download

Terraform v0.12 is installed in this disk image. If you need to download Terraform, it's available at this link:

[Download Terraform](https://www.terraform.io/downloads.html)

To download, use a command line tool like `wget` on Linux or Mac:

```
wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
```

### Unzip

Unzip the Terraform executable:

```
unzip terraform_*
```

### Verify version

Verify that you are running Terraform 0.12 or greater.

```
terraform version
```

You should see `v0.12.2` or greater in the output.

```
Terraform v0.12.2
```

If you are using a locally downloaded version if Terraform in the current directory, use `./terraform` (leading dot slash) to run the command.

NOTE: On any error, verify that you're using Terraform `0.12` or greater with `./terraform version`

### Optional: Skip to final code in `after` branch

We think you'll learn the most if you go through this tutorial step-by-step. But if at any point you want to skip to the final Terraform configuration for the project, you can find it in the `after` branch in the Git repository we've cloned for you.

Delete all your changes first with `git reset`:

```
git reset --hard HEAD
```

Then checkout the `after` branch with this command:

```
git checkout -t origin/after
```

You can provision the infrastructure defined in the final code with these commands:

```
./terraform init && ./terraform apply -auto-approve
```

## Write a configuration

### Set Project Name

Set GCP project name from your account.

https://console.cloud.google.com/home/dashboard

For the purposes of this example, we will use `terraform-project` but you should use your actual project name.

```
provider "google" {
  project = "terraform-project"
  region  = "us-central1"
  zone    = "us-central1-c"
}
```

### Define a network

```
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
```

### Init

```
terraform init
```

### Plan

```
terraform plan
```

### Apply

```
terraform apply
```

You should see:

```
Terraform will perform the following actions:

...

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
```

Answer **yes**.

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## Change the configuration

### Define a firewall

```
resource "google_compute_firewall" "default" {
  name    = "terraform-firewall"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }
}
```

```
terraform apply
```

### Define a compute instance

```
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  labels = {
    billing_department = "education"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

  metadata_startup_script = "echo 'Hello Terraform on GCP!' > index.html; python -m SimpleHTTPServer 9000 &"
}
```

### Show state

```
terraform show
```

Scroll up to `network_interface` and `access_config` and `nat_ip`. You'll find an IP address something like `0.0.0.0`.

Go to your web browser and type that IP address followed by port `9000`. It will look something like (but use the IP address you found earlier):

```
http://0.0.0.0:9000
```

You should see the message "Hello Terraform on GCP!"

## Define an output

### Display the website URL

```
output "public_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
```

```
output "website_url" {
  value = "http://${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip}:9000"
}
```

### See final code

```
git reset --hard HEAD
```


```
git checkout -t origin/after
```

## Destroy

```
terraform destroy
```

```
Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy all resources?
```

It may take a few minutes to complete.

```
Destroy complete! Resources: 3 destroyed.
```

## Conclusion

Done!

[Learn more about Terraform](https://learn.hashicorp.com/terraform/)
