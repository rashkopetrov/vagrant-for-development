class DevBox
  def self.init(config)
    require './lib/devboxconf.rb'
    DevBoxConf.init(config)

    require './lib/devboxvm.rb'
    DevBoxVM.init()

    require './lib/devboxports.rb'
    DevBoxPorts.forward()

    require './lib/devboxpackages.rb'
    DevBoxPackages.install_packages()

    require './lib/devboxfiles.rb'
    DevBoxFiles.sync()

    require './lib/devboxfolders.rb'
    DevBoxFolders.sync()

    require './lib/devboxkeys.rb'
    DevBoxKeys.sync()

    require './lib/devboxsites.rb'
    DevBoxSites.init()

    require './lib/devboxscripts.rb'
    DevBoxScripts.init()
  end
end
