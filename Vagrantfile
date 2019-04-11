# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION ||= "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.require_version '>= 2.1.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    require './lib/devbox.rb'
    DevBox.init(config)
end
