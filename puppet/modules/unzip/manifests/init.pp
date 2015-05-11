# vagrant/puppet/modules/unzip/manifests/init.pp
class unzip {
    # Install the unzip package
    package { ['unzip']:
        ensure => present,
        require => Exec['apt-get update']
    }
}
