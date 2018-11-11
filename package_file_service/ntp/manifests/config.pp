# populate ntp config file
class ntp::config {
  file { $ntp::config_file:
    ensure  => file,
    content => template('ntp/ntpd.conf.erb'),
  }
}
