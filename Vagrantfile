# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provision :shell, :path => ".provision/bootstrap.sh", 
    env: {
    "USER_NAME" => "value",
    "PASSWORD" => "value32"
  }

  config.vm.box = "ubuntu/xenial64"

  config.vm.network :forwarded_port, guest: 8080, host: 80, auto_correct: true
  config.vm.network :private_network, ip: "192.168.68.8"
  # For this to work fully you need to install extension pack
  # for mac: brew cask install virtualbox-extension-pack
  config.vm.synced_folder "src/", "/var/www/html/public"
  # cp src/ /var/www/html/public
end
