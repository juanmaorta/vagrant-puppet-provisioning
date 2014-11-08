# vagrant/puppet/modules/varnish/manifests/init.pp
class varnish {
  # Install the apt-transport-https
  package { 'apt-transport-https':
    ensure => 'present',
    require => Exec['apt-get update'],
  }

  # get the Varnish GPG key
  exec { 'download_varnish_key':
    command => 'curl https://repo.varnish-cache.org/ubuntu/GPG-key.txt | sudo apt-key add -',
    path    => ['/bin', '/usr/bin'],
    require => Package['apt-transport-https'],
  }

  # add the Varnish repo
  exec { 'varnish_repo':
    command => 'sudo sh -c \'echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list\'',
    path    => ['/bin', '/usr/bin'],
    require => Exec['download_varnish_key'],
  }

  package { 'varnish':
  	ensure => 'present',
  	require => [
  		Exec['varnish_repo'],
  		Exec['apt-get update']
  	],
  }

  file { 'varnish_conf':
    path => '/etc/default/varnish',
    ensure => file,
    require => Package['varnish'],
    source => 'puppet:///modules/varnish/varnish'
  }

    file { 'varnish_default_vcl':
    path => '/etc/varnish/default.vcl',
    ensure => file,
    require => Package['varnish'],
    source => 'puppet:///modules/varnish/default.vcl'
  }

  # Make sure varnish is running
  service { 'varnish':
    ensure => running,
    require => Package['varnish'],
  }
}