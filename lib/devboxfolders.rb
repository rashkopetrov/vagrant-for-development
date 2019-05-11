require './lib/devboxconf.rb'

class DevBoxFolders
  def self.sync
    folders = DevBoxConf.settings('folders')

    return if folders.nil?

    if folders.to_s.length.zero?
      abort 'Check your config.json file, you have no folders specified.'
    end

    folders.each do |folder_data|
      DevBoxFolders.sync_folder(folder_data)
    end
  end

  def self.sync_folder(folder_data)
    if !File.exist? File.expand_path(folder_data['host_directory'])
      DevBoxConf.config.vm.provision 'shell' do |s|
        s.inline = ">&2 echo \"Unable to mount one of your folders. Please check your folders in config.json\""
      end
    end

    mount_opts = []

    if folder_data['type'] == 'nfs'
      mount_opts = folder_data['mount_options'] ? folder_data['mount_options'] : ['actimeo=1', 'nolock']
    elsif folder_data['type'] == 'smb'
      mount_opts = folder_data['mount_options'] ? folder_data['mount_options'] : ['vers=3.02', 'mfsymlinks']

      smb_creds = {'smb_host': folder_data['smb_host'], 'smb_username': folder_data['smb_username'], 'smb_password': folder_data['smb_password']}
    elsif folder_data['mount_options']
      mount_opts = folder_data['mount_options']
    end

    # For b/w compatibility keep separate 'mount_opts', but merge with options
    options = (folder_data['options'] || {}).merge({ mount_options: mount_opts }).merge(smb_creds || {})

    # Double-splat (**) operator only works with symbol keys, so convert
    options.keys.each{|k| options[k.to_sym] = options.delete(k) }

    DevBoxConf.config.vm.synced_folder folder_data['host_directory'], folder_data['guest_directory'], type: folder_data['type'] ||= nil, owner: folder_data['owner'] ||= 'vagrant', group: folder_data['type'] ||= 'vagrant', **options

    # Bindfs support to fix shared folder (NFS) permission issue on Mac
    if folder_data['type'] == 'nfs' && Vagrant.has_plugin?('vagrant-bindfs')
      DevBoxConf.config.bindfs.bind_folder folder_data['guest_directory'], folder_data['guest_directory']
    end
  end
end
