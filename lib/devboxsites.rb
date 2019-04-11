require './lib/devboxconf.rb'
require './lib/devboxscript.rb'
require './lib/devboxfolders.rb'

class DevBoxSites
  def self.init
    sites = DevBoxConf.settings('sites')

    return if sites.nil?

    if sites.to_s.length.zero?
      abort 'Check your config.json file, you have no sites specified.'
    end

    DevBoxSites.clear_sites()

    sites.each do |site_data|
      DevBoxSites.validate(site_data)

      DevBoxSites.configure_site(site_data)
    end
  end

  protected
  def self.configure_site(site_data)
    server_root = site_data['server_root']
    DevBoxFolders.sync_folder(server_root)

    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/nginx/create-site.sh')
    script_args      = [
      site_data['server_name'], server_root['to']
    ]

    DevBoxScript.run_on_guest(script_full_path, script_args, "always")
  end

  protected
  def self.clear_sites
    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/nginx/clear-sites.sh')
    DevBoxScript.run_on_guest(script_full_path, nil, "always")
  end

  protected
  def self.validate(site_data)
    if !site_data['server_name']
      abort 'Check your config.json file, Site server_name not specified.'
    end

    if !site_data['server_root']
      abort 'Check your config.json file, Site server_root settings not specified.'
    end
  end
end
