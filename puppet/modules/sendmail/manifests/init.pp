# vagrant/puppet/modules/sendmail/manifests/init.pp
class sendmail {
  # Install the nginx package. This relies on apt-get update
  package { 'sendmail':
    ensure => 'present',
    require => Exec['apt-get update'],
  }

  # Make sure that the nginx service is running
  service { 'sendmail':
    ensure => running,
    require => Package['sendmail'],
  }
}
