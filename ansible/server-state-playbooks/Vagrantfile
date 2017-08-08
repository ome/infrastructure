Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 4064, host: 4064
    config.vm.network "forwarded_port", guest: 4063, host: 4063
  end

  [
    "ome-dundeeomero",
    "ome-demoserver",
    "nightshade-web"
  ].each do |server|
    config.vm.define "#{server}" do |node|
      node.vm.box = "centos/7"
      node.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/#{server}.yml"
  config.vm.provision "ansible" do |ansible|
    ansible.skip_tags = "lvm"
    ansible.playbook = "#{server}.yml"
    ansible.galaxy_role_file = "requirements.yml"
  end
end
