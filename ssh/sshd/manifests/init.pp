class sshd {

  require sudo

  include sshd::params, sshd::install, sshd::config, sshd::service, sshd::users, sshd::bashrc

}
