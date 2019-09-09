# Terraform Intro Demo

Before and after code for a _Terraform Introduction_ class.

## Terraform Cloud

This branch is for use with a student's own AWS credentials and is intended to run on Terraform Cloud (but can also run locally).

Major changes:

- A security group is created for SSH and HTTP
- The configuration only uses resources built by the configuration itself
- `public_key` and `private_key` should be provided as contents rather than a path to a file.
- AWS credentials should be provided as environment variables.

    export AWS_ACCESS_KEY_ID="AAAA"
    export AWS_SECRET_ACCESS_KEY="AAAA"
    export AWS_DEFAULT_REGION="us-west-2"
    
## Branches

See the `after` branch for the completed code from the class.

See the `after-byoaws` branch for the completed code that can be run on a student's own AWS account (instead of on the instructor-created AWS account).

