define sshd::user ( $ensure, $home="/home/${title}", $shell='/bin/bash', $uid, $gid, $groups = [], $umask = hiera('sshd_bashrc_umask'), $sshkeytype, $sshkey) {

  $username = $title

  if $ensure == 'absent' {

  # We need a separate ensure variable for the bashrc.d directory, as directories are created/deleted with 'directory' and 'absent'

  $dirensure = 'absent'

  # We want to disable recursion on bashrc.d when we delete it

  $recurse = 'false'

  # Manage key before the user to prevent ordering conflicts

  Ssh_authorized_key[$username] -> User[$username]

  } elsif $ensure == 'present' {

  $dirensure = 'directory'
  $recurse = 'true'

  # Manage user before the key to prevent ordering conflicts

  User[$username] -> Ssh_authorized_key[$username]

  }

  # Create user

  user { $username:
    ensure     => $ensure,
    comment    => "$username",
    home       => $home,
    shell      => $shell,
    uid        => $uid,
    gid        => $gid,
    groups     => $groups,
    managehome => true,
  }


  file { "${home}/.bashrc.d":
    ensure  => $dirensure,
    owner   => "$username",
    group   => $gid,
    mode    => '0770',
    source  => 'puppet:///modules/sshd/bashrc.d',
    recurse => $recurse
  }

  ssh_authorized_key { $username:
    ensure => $ensure,
    user   => $username,
    type   => $sshkeytype,
    key    => $sshkey,
    name   => "$username"
  }

}
