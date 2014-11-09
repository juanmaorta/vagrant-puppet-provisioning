# vagrant/puppet/modules/redis/manifests/init.pp
class redis {
    # Install the redis package
    package { ['redis-server']:
        ensure => present,
        require => Exec['apt-get update']
    }

    # Make sure that the redis service is running
  	service { 'redis-server':
    	ensure => running,
    	require => Package['redis-server'],
  	}
}