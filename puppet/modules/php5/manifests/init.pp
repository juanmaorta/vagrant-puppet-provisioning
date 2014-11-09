# vagrant/puppet/modules/php/manifests/init.pp
class php5 {
    # Install the php5-fpm, php5-cli and php5-mysql packages
    package { ['php5-fpm','php5-cli','php5-mysql', 'php5-gd', 'php5-curl', 'php5-mcrypt', 'php-apc']:
        ensure => present,
        require => Exec['apt-get update'],
    }

    # Symlink mcrypt module
    #exec { 'symlink_mcrypt':
    #  command => 'ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/fpm/conf.d/mcrypt.ini',
    #  path    => ['/bin', '/usr/bin'],
    #  require => Service['php5-fpm'],
    #}

    # Symlink mcrypt module
    file { 'symlink_mcrypt':
      path => '/etc/php5/mods-available/mcrypt.ini',
      target => '/etc/php5/fpm/conf.d/mcrypt.ini',
      ensure => link,
      require => Package['php5-fpm']
    }

    # Composer
    exec { 'get_composer':
        command => 'curl -sS https://getcomposer.org/installer | php',
        path    => ['/bin', '/usr/bin'],
        require => Package['php5-cli'],
    }

    exec { 'composer_global':
        command => 'sudo mv composer.phar /usr/local/bin/composer',
        path    => ['/bin', '/usr/bin'],
        require => Exec['get_composer'],
    }

    # Make sure php5-fpm is running
    service { 'php5-fpm':
        ensure => running,
        require => Package['php5-fpm'],
    }
}
