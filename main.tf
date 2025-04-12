terraform {
  required_providers {
    aws = {
    source = "aws"
    version = "5.94.1"
    }
  }
}

resource "aws_iam_user" "sys_admin" {
  count = 3
  name = "syst_admin${count.index}"
}
resource "aws_iam_user" "db_admin" {
  count = 3
  name = "db_admin${count.index}"
}
resource "aws_iam_user" "ro_user" {
  count = 3
  name = "ro_user${count.index}"
}


resource "aws_iam_group" "iam_groups" {
for_each =  toset([ "ro_user_group", "db_admin_group", "sys_admin_group" ])
    name = each.key
}

resource "aws_iam_group_membership" "sys_admin_assignment" {
  name = "sys_admin_assignment"
  users = [
    aws_iam_user.sys_admin[0].name,
    aws_iam_user.sys_admin[1].name,
    aws_iam_user.sys_admin[2].name
  ]
  group = "sys_admin_group"
}

resource "aws_iam_group_membership" "db_admin_assignment" {
  name = "db_admin_assignment"
  users = [
    aws_iam_user.db_admin[0].name,
    aws_iam_user.db_admin[1].name,
    aws_iam_user.db_admin[2].name
  ]
  group = "db_admin_group"
}

resource "aws_iam_group_membership" "ro_user_assignment" {
  name = "ro_user_assignment"
  users = aws_iam_user.ro_user[*].name
  
  group = "ro_user_group"
}

 resource "aws_iam_account_password_policy" "strict" {
   minimum_password_length        = 7
   require_numbers                = true
   require_uppercase_characters   = true
   require_symbols                = true
   allow_users_to_change_password = true
 }
/*
 resource "aws_iam_group_policy_attachment" "group_policy_assignments" {
   for_each =  aws_iam_group.iam_groups
   group = each.value.name
   policy_arn = 
 }
 */