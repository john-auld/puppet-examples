class sshd::config {

  $sshd_permit_root_login       = hiera('sshd_permit_root_login')
  $sshd_password_authentication = hiera('sshd_password_authentication')
  $sshd_bashrc_umask            = hiera('sshd_bashrc_umask')
  $sshd_sftp_subsystem          = hiera('sshd_sftp_subsystem')
  $sshd_matchrules              = hiera('sshd_matchrules', '')
  $sshd_allow_users_custom      = hiera_array('sshd_allow_users')
  $sshd_users                   = hiera_hash('sshd_users')

  # Fetch just the usernames, not the whole hash

  $sshd_usernames = keys($sshd_users)

  # Sort usernames lexically

  $sshd_usernames_sorted = sort($sshd_usernames)

  # For the AllowUsers list in sshd_config we combine the list of provisioned users
  # with an editable list in Hiera, just in case we need to add users that fall outside
  # of Puppet's control (for example, root)

  $sshd_allow_users = concat($sshd_allow_users_custom, $sshd_usernames_sorted)

  # Set up sshd configuration file

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    mode    => '0600',
    content => template($sshd::params::sshd_template)
  }

}
