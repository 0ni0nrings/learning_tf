resource "aws_iam_role" "lambda-role" {
  name        = "lambda-role"
  description = "role for executing lambda functions"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
# "aws_iam_role_policy" is for inline policy whereas the below is for managed policy
resource "aws_iam_policy" "lambda-role-policy" {
  name   = "lambda-role-policy"
  path   = "/"
  description = "Managed policy for lamda-role"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "lambda-policy-attach" {
  role       = "${aws_iam_role.lambda-role.name}"
  policy_arn = "${aws_iam_policy.lambda-role-policy.arn}"
}