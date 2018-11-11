# install package
class ntp::install {
  package { $ntp::package_name:
    ensure => installed,
  }
}
