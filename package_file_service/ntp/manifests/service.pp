# ntp service
class ntp::service {
  service { $ntp::service_name:
    ensure => running,
  }
}
