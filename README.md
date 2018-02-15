# Terraform Intro Demo

Before and after code for a _Terraform Introduction_ class.

## BYO AWS

This branch is for use on an account created by an instructor, with some resources created in advance (security group, an AMI with the Go web application installed). 

This is useful for high security environments where SSH egress is not allowed from student workstations.

Major changes:

- Only a few external variables are needed (security group ID, AMI, identity, etc.)
- SSH is not required; the AMI already has the web application installed

