{
  "Id": "Policy1527877254663",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1527877245190",
      "Action": [
        "s3:CreateBucket",
        "s3:DeleteBucket",
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:ListObjects"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${bucket_name}"
    }
  ]
}
