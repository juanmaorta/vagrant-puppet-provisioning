# vagrant/puppet/modules/php/manifests/init.pp
class php5 {
    # Install the php5-fpm, php5-cli and php5-mysql packages
    package { ['php5-fpm','php5-cli','php5-mysql']:
        ensure => present,
        require => Exec['apt-get update'],
    }

    # Make sure php5-fpm is running
    service { 'php5-fpm':
        ensure => running,
        require => Package['php5-fpm'],
    }
}
