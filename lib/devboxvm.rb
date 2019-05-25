require './lib/devboxconf.rb'

class DevBoxVM
  def self.init
    DevBoxConf.config.vm.define DevBoxConf.settings('name', 'DevBox')
    DevBoxConf.config.vm.box              = DevBoxConf.settings('box', 'debian/stretch64')
    DevBoxConf.config.vm.hostname         = DevBoxConf.settings('hostname', 'localhost')
    DevBoxConf.config.vm.boot_timeout     = DevBoxConf.settings('boot_timeout', 300)
    DevBoxConf.config.vm.box_check_update = DevBoxConf.settings('box_check_update', true)

    DevBoxConf.config.vm.provider "virtualbox" do |vb|
      vb.gui    = DevBoxConf.settings('gui', false)
      vb.cpus   = DevBoxConf.settings('cpus', 1)
      vb.memory = DevBoxConf.settings('memory', 2048)
    end

    # Configure A Private Network IP
    if DevBoxConf.settings('ip') == 'autonetwork'
      DevBoxConf.config.vm.network :private_network, ip: '0.0.0.0', auto_network: true
      return
    end

    DevBoxConf.config.vm.network :private_network, ip: DevBoxConf.settings('ip', '192.168.10.10')
  end
end
