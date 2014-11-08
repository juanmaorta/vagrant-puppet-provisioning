# vagrant/puppet/modules/php/manifests/init.pp
class php5 {
    # Install the php5-fpm, php5-cli and php5-mysql packages
    package { ['php5-fpm','php5-cli','php5-mysql', 'php5-gd', 'php5-curl', 'php5-mcrypt', 'php-apc']:
        ensure => present,
        require => Exec['apt-get update'],
    }

    # Symlink mcrypt module
    exec { 'symlink_mcrypt':
      command => 'ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/fpm/conf.d/mcrypt.ini',
      path    => ['/bin', '/usr/bin'],
      require => Service['php5-fpm'],
    }

    # Make sure php5-fpm is running
    service { 'php5-fpm':
        ensure => running,
        require => Package['php5-fpm'],
    }
}
