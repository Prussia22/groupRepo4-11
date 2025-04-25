terraform {
  required_providers {
    aws = {
    source = "hashicorp/aws"
    version = "5.94.1"
  }
}
}

module "iam_module" {
  source = "./modules/iam_module"
  users = [
    {
        name = "john_doe"
        job = "sys_admin"
    },
    {
        name = "alice_smith"
        job = "db_admin"
    },
    {
        name = "joe_green"
        job = "ro_user"
    },
    {
        name = "mary_jones"
        job = "sys_admin"
    },
    {
        name = "thomas_booke"
        job = "db_admin"
    }
]
permissions = [ {
  name = "sys_admin"
  policies = [ "arn:aws:iam::aws:policy/AdministratorAccess" ]
}, {
  name = "db_admin"
  policies = [ "arn:aws:iam::aws:policy/job-function/DatabaseAdministrator" ]
}, {
  name = "ro_user"
  policies = [ "arn:aws:iam::aws:policy/AmazonConnectReadOnlyAccess", "arn:aws:iam::aws:policy/AIOpsReadOnlyAccess" ]
}]
}