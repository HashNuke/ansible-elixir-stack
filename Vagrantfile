# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "vagrant"
  config.vm.network "private_network", ip: "33.33.33.10"


  # Lifted straight from http://stackoverflow.com/a/31153912
  config.vm.provision "shell" do |shell|
    public_key = File.read("#{Dir.home}/.ssh/id_rsa.pub").strip
    shell.inline = <<-SHELL
      apt-get install python -y
      printf '\n#{public_key}\n' >> /home/ubuntu/.ssh/authorized_keys
      printf '\n#{public_key}\n' >> /root/.ssh/authorized_keys
    SHELL
  end


  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
end
