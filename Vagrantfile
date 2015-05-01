Vagrant.configure(2) do |config|

    # Base box
    config.vm.box = "ubuntu/trusty64"

    # Port Forwarding
    config.vm.network "forwarded_port", guest: 80, host: 8080   #Apache
    config.vm.network "forwarded_port", guest: 3306, host: 3306 #MySQL

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network "private_network", ip: "192.168.33.10"

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../sites", "/vagrant_data"
    config.vm.synced_folder "../sites", "/sites", owner: "vagrant", group: "vagrant"
    
    
#    # Enable visual virtual box
#    config.vm.provider "virtualbox" do |vb|
#        vb.gui = true
    
#    # Customize the amount of memory on the VM:
#        vb.memory = "1024"
#    end
    
    config.vm.provision "shell", path: "bootstrap.sh"
end
