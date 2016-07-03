# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  # Lifted straight from http://stackoverflow.com/a/31153912
  config.vm.provision "shell" do |shell|
    public_key = File.read("#{Dir.home}/.ssh/id_rsa.pub").strip
    shell.inline = <<-SHELL
      echo #{public_key} >> /home/vagrant/.ssh/authorized_keys
      echo #{public_key} >> /root/.ssh/authorized_keys
    SHELL
  end


  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
end
