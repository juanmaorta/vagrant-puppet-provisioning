# vagrant/puppet/modules/git/manifests/init.pp
class git {
    # Install the git package
    package { ['git']:
        ensure => present,
        require => Exec['apt-get update']
    }
}