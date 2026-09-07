# ---------- IAM GROUP ----------
resource "aws_iam_group" "client_group" {
  name = var.iam_group_name
}

# ---------- IAM USER ----------
resource "aws_iam_user" "client_user" {
  name = var.iam_user_name
}

# User ko group mein add karein
resource "aws_iam_user_group_membership" "client_membership" {
  user   = aws_iam_user.client_user.name
  groups = [aws_iam_group.client_group.name]
}

# Group ko S3 Full Access policy attach karein
resource "aws_iam_group_policy_attachment" "s3_full_access" {
  group      = aws_iam_group.client_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Group ko EC2 Full Access policy attach karein
resource "aws_iam_group_policy_attachment" "ec2_full_access" {
  group      = aws_iam_group.client_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# ---------- IAM ROLE ----------
# Ye role EC2 service assume karega (trust policy)
resource "aws_iam_role" "client_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Role ko S3 Full Access policy attach karein
resource "aws_iam_role_policy_attachment" "role_s3_full_access" {
  role       = aws_iam_role.client_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Role ko EC2 Full Access policy attach karein
resource "aws_iam_role_policy_attachment" "role_ec2_full_access" {
  role       = aws_iam_role.client_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}