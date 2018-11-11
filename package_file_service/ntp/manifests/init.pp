# Package, file, service example
class ntp {

  case $facts['osfamily'] {
    'RedHat': {
      $package_name = 'ntp'
      $config_file  = '/etc/ntp.conf'
      $service_name = 'ntpd'
    }
  }

  class { 'ntp::install': }
  -> class { 'ntp::config': }
  ~> class { 'ntp::service': }

}
