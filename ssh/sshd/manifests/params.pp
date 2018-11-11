class sshd::params {

  $sshd_config_template  = hiera('sshd_config_custom_config', 'use_standard_sshd_config')

  if $sshd_config_template != 'use_standard_sshd_config' {
    $sshd_template = "sshd/$sshd_config_template"
  }
  else {
    case $::operatingsystemmajrelease {
      '5', '6': {
        $sshd_template = 'sshd/sshd_config.erb'
      }

      '7': {
        $sshd_template = 'sshd/sshd_config-centos7.erb'
      }
    }
  }

  $profile_d_user_settings_file = "/etc/profile.d/sd_bashrc.sh"

}
