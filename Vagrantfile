# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  (1..2).each do |i|
		config.vm.define "buildx#{i}" do |node|
      node.vm.network "private_network", ip: "192.168.56.1#{i}", virtualbox__intnet: "pxe_lab_network"
      node.ssh.forward_agent = true

      node.vm.provider "buildx#{i}" do |vb|
        vb.gui = true  
        vb.memory = "2048"
      end

      node.vm.hostname = "buildx#{i}"
    
      node.vm.provision "shell", inline: <<-SHELL
        # Install docker
        apt-get update
        apt-get remove docker docker-engine docker.io containerd runc
        apt-get upgrade -y
        apt-get install -y \
          ca-certificates \
          curl \
          gnupg \
          lsb-release
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
        
        # Setup ssh-key
        cat /vagrant/ssh-key/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys

        # Prevent ssh host checking
        mkdir -p  /etc/ssh/ssh_config.d
        cat > /etc/ssh/ssh_config.d/no-host-checking.conf <<- EOM
Host *
    StrictHostKeyChecking no
EOM

        # Setup docker remote ssh
        sudo usermod -aG docker vagrant
        newgrp docker
      SHELL
		end
	end
end
