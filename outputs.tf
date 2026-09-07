output "iam_user_name" {
  value = aws_iam_user.client_user.name
}

output "iam_user_arn" {
  value = aws_iam_user.client_user.arn
}

output "iam_group_name" {
  value = aws_iam_group.client_group.name
}

output "iam_role_name" {
  value = aws_iam_role.client_role.name
}

output "iam_role_arn" {
  value = aws_iam_role.client_role.arn
}