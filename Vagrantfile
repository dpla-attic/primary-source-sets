
Vagrant.configure(2) do |config|
  config.vm.define 'pss' do |pss|
    pss.vm.box = 'hashicorp/precise64'  # Ubuntu 12.04 LTS
    pss.vm.hostname = 'pss'
    pss.vm.network :private_network, ip: '192.168.50.22'
    pss.vm.network "forwarded_port", guest: 3000, host: 3000  # Rails
    pss.vm.network "forwarded_port", guest: 3001, host: 3001  # Jasmine
    pss.vm.provider 'virtualbox' do |vb|
      vb.memory = 1024
    end
    pss.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'provisioning/provision.yml'
    end
  end
end
