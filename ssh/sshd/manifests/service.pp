class sshd::service {

  service { 'sshd':
    ensure     => running,
    enable     => true,
    subscribe  => File['/etc/ssh/sshd_config'],
    hasrestart => true,
    hasstatus  => true,
    require    => Class[sshd::install],
  }

}
