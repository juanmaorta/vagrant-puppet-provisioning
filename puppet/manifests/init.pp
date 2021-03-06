exec { 'apt-get update':
    path => '/usr/bin',
}

package { 'vim':
    ensure => present,
}

file { '/var/www/':
    ensure => 'directory',
}

# -nginx, -mysql, -php5-fpm, -php5-cli, -php5-mysql, -redis, redis php ? (better via composer), -apache2, apache mod rewrite, -curl, -gd, -git, -composer, -varnish, -sendmail
# ssl certs
# named?

include nginx, sendmail, php5, nodejs, apache2, varnish, redis, git, mysql
