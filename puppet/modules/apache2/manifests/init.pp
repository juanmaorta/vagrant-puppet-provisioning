# vagrant/puppet/modules/apache/manifests/init.pp
class apache2 {

  # Install the nginx package. This relies on apt-get update
  package { ['apache2','libapache2-mod-php5']:
    ensure => 'present',
    require => Exec['apt-get update'],
  }

  # Symlink vhost
  file { 'symlink_modvhost':
    path => '/etc/apache2/mods-available/vhost_alias.load',
    target => '/etc/apache2/mods-enabled/vhost_alias.load',
    ensure => link,
    require => Package['apache2'],
    notify => Service['apache2']
  }

  # Symlink rewrite
  file { 'symlink_modrewrite':
    path => '/etc/apache2/mods-available/rewrite.load',
    target => '/etc/apache2/mods-enabled/rewrite.load',
    ensure => link,
    require => Package['apache2'],
    notify => Service['apache2']
  }

  # Add a vhost template
  file { 'vagrant-apache2':
    path => '/etc/apache2/sites-available/127.0.0.1',
    ensure => file,
    require => Package['apache2'],
      source => 'puppet:///modules/apache2/127.0.0.1',
  }

  file { 'vagrant-ports':
    path => '/etc/apache2/ports.conf',
    ensure => file,
    require => Package['apache2'],
      source => 'puppet:///modules/apache2/ports.conf',
  }

  # Disable the default apache vhost
  file { 'default-apache2-disable':
    path => '/etc/apache2/sites-enabled/000-default.conf',
    ensure => absent,
    require => Package['apache2'],
  }

  # Symlink our vhost in sites-enabled to enable it
  file { 'vagrant-apache2-enable':
    path => '/etc/apache2/sites-enabled/127.0.0.1',
    target => '/etc/apache2/sites-available/127.0.0.1',
    ensure => link,
    notify => Service['nginx'],
    require => [
      File['vagrant-apache2'],
      File['default-apache2-disable'],
    ],
  }

  # Make sure that the apache service is running
  service { 'apache2':
    ensure => running,
    require => Package['apache2'],
  }
}