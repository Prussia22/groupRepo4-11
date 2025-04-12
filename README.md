# groupRepo4-11
Resources I need ?
1. IAM User
    1a. 3 system_admin Users
    1b. 3 database_admin Users
    1c. 3 read only users
2. IAM Groups
    2a. 1 group for system admins
    2b. 1 group for database admins
    2c. 1 group for read only users
3. Assign Users to Groups
    3a. system admin users > system admin group
    3b. database admin users > database admin group
    3c. read only users > read only group
4. Password Policy
5. Assign Permissions
    5a. System Admin gets AdministratorAccess
    5b. Database Admin gets DatabaseAdministrator
    5c. Read Only gets AmazonConnectReadOnlyAccess
 
# For each 
# Maps
# Terraform Functions
