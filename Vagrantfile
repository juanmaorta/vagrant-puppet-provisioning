# http://jamesmcfadden.co.uk/using-vagrant-and-puppet-to-build-a-php-nginx-and-mysql-environment/
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, host: 8080, guest: 80 #nginx
  # config.vm.network :forwarded_port, host: 4000, guest: 443 #nginx

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path = 'puppet/modules'
    puppet.manifest_file = 'init.pp'
  end
end
