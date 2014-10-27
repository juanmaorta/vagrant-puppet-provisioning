# vagrant/puppet/modules/node/manifests/init.pp
class nodejs {
  # Install the node package. This relies on apt-get update
  package { 'node':
    ensure => 'present',
    require => Exec['apt-get update'],
  }

  package { 'nodejs':
    ensure => 'present',
    require => Exec['apt-get update'],
  }

  package { 'npm':
    ensure => 'present',
    require => Exec['apt-get update'],
  }
}
