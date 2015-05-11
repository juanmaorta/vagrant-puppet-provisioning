# vagrant/puppet/modules/wordpress/manifests/init.pp
class wordpress {
  exec{'retrieve_wordpress':
    command => "/usr/bin/wget -q https://wordpress.org/wordpress-4.2.2.zip -O /vagrant/wordpress-4.2.2.zip"
  }

  exec{'unzip_wordpress':
    command => "/usr/bin/unzip /vagrant/wordpress-4.2.2.zip",
    require => Package['unzip']
  }
}
