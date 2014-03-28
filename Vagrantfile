Vagrant.configure("2") do |config|
	config.vm.box = "hashicorp/precise32"
	config.vm.network :forwarded_port, host: 4567, guest: 80
	config.vm.synced_folder "./", "/vagrant", id: "vagrant-root"

	config.vm.provider :virtualbox do |vb|
		vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
	end

	config.vm.provision :shell, :path => "shell/main.sh"

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = "puppet/manifests"
		puppet.manifest_file = "main.pp"
		puppet.options = ["--verbose"]
	end

	config.vm.provision :shell, :path => "shell/finish.sh"
end
