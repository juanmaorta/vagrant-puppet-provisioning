exec { 'apt-get update':
    path => '/usr/bin',
}

package { 'vim':
    ensure => present,
}

file { '/var/www/':
    ensure => 'directory',
}


include nginx, sendmail, php5, git, mysql, unzip, wordpress
