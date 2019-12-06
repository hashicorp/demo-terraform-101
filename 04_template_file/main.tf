variable "owner_id" {
  default = "anaconda"
}

locals {
  policy = templatefile("${path.module}/templates/iam_policy.json.tpl", {
    owner_id = var.owner_id
    bucket_name = "${var.owner_id}-${uuid()}"
  })
}


provider "aws" {
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "${var.owner_id}-${uuid()}"
  acl = "private"
}

resource "aws_iam_policy" "bucket1"{
  name = "${aws_s3_bucket.bucket1.id}-policy"
  policy = local.policy
}

resource "aws_iam_user_policy_attachment" "attach-policy" {
  user       = var.owner_id
  policy_arn = aws_iam_policy.bucket1.arn
}

output "iam_policy" {
  value = local.policy
}
