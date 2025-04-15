terraform {
  required_providers {
    aws = {
    source = "aws"
    version = "5.94.1"
    }
  }
}

locals {
  #Creates a map of {user = job}
  user_jobs = {for x in var.users : x.name => x.job}
  #Finds each unique job type and creates a list
  job_types = toset([for x in var.users : x.job])
  #Creates an object where each policy is associated with its job
  permissions = merge([for prms in var.permissions : {for plc in prms.policies[*] : plc => prms.name}]...)
}

resource "aws_iam_user" "default" {
  for_each = local.user_jobs
  name = each.key
}

resource "aws_iam_group" "default" {
  for_each = local.job_types
  name = each.value
  depends_on = [ aws_iam_user.default ]
}

resource "aws_iam_group_membership" "default" {
  for_each = local.job_types
  name = "${each.value}-membership"
  group = each.value
  users = [
    for x in var.users : x.name if x.job == each.value
  ]
  depends_on = [ aws_iam_group.default ]
}

resource "aws_iam_account_password_policy" "default" {
  minimum_password_length        = 9
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

resource "aws_iam_group_policy_attachment" "default" {
  for_each = local.permissions
  group = each.value
  policy_arn = each.key
  depends_on = [ aws_iam_group.default ]
}
