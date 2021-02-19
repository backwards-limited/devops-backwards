provider "aws" {
  profile = "david"
  region = "eu-west-2"
}

resource "aws_s3_bucket" "finance" {
  bucket = "finance-21092020"

  tags = {
    Description = "Finance and Payroll"
  }
}

resource "aws_s3_bucket_object" "finance-2020" {
  bucket = aws_s3_bucket.finance.id
  key = "data.txt"
  content = "data.txt"
}

data "aws_iam_group" "finance-data"{
  group_name = "finance-analysts"
}

resource "aws_s3_bucket_policy" "finance-policy" {
  bucket = aws_s3_bucket.finance.id
  policy = <<EOF
{
  "Version": "2012-10-17,
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.finance.id}/*",
      "Principal": {
        "AWS": [
          "${data.aws_iam_group.finance-data.arn}"
        ]
      }
    }
  ]
}
EOF
}