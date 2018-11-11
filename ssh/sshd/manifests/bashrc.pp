class sshd::bashrc {

  # add bashrc settings for all users
  file { "${::sshd::params::profile_d_user_settings_file}":
    content => template("${module_name}/sd_bashrc.sh.erb"),
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
  }

}
