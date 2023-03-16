# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	VM_BOX = "bento/ubuntu-20.04"
  
	CONTROL_IP = "10.0.20.10"
	CONTROL_CPUS = 2
	CONTROL_MEM = 2048
	CONTROL_HOSTNAME = "control-tf"

  PATH_COMMON_SCRIPT  = "scripts/common.sh"
  PATH_CONTROL_SCRIPT  = "scripts/control_tf.sh"

  # configuration du node `control plane`
	config.vm.define CONTROL_HOSTNAME do |cp|
		cp.vm.box = VM_BOX
		cp.vm.hostname= CONTROL_HOSTNAME
		cp.vm.network "private_network", ip: CONTROL_IP
		cp.vm.provider "virtualbox" do |v|
			v.memory = CONTROL_MEM
			v.cpus = CONTROL_CPUS
			v.name = CONTROL_HOSTNAME
		end # end v

		cp.vm.provision :shell, path: PATH_COMMON_SCRIPT
		cp.vm.provision :shell, path: PATH_CONTROL_SCRIPT
		
  		# Provisioning configuration for Ansible.
        cp.vm.provision "ansible" do |ansible|
	        ansible.playbook = "playbook.yml"
	    end



	end # end cp

end # end config