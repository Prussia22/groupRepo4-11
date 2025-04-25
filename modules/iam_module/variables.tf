#User can have the job of sys_admin, db_admin, or ro_user
variable "users" {
    type = set(object({
      name = string
      job = string
    }))
}
variable "permissions" {
    type = set(object({
        name = string
        policies = list(string)
    }))
}