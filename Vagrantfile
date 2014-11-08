# http://jamesmcfadden.co.uk/using-vagrant-and-puppet-to-build-a-php-nginx-and-mysql-environment/
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, host: 5000, guest: 80 #varnish
  config.vm.network :forwarded_port, host: 7000, guest: 8000 #nginx
  config.vm.network :forwarded_port, host: 4000, guest: 443 #nginx
  config.vm.network :forwarded_port, host: 9000, guest: 8080 #apache

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path = 'puppet/modules'
    puppet.manifest_file = 'init.pp'
  end
end
