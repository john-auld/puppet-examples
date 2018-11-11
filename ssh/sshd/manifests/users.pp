class sshd::users {

# Use hiera_hash to get users from all levels of the hierarchy

  $users  = hiera_hash('sshd_users')

# This users our sshd::user definition to create users/groups/keys from the data from Hiera

create_resources(sshd::user, $users)

}
