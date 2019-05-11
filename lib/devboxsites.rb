require './lib/devboxconf.rb'
require './lib/devboxfiles.rb'
require './lib/devboxscript.rb'
require './lib/devboxfolders.rb'

class DevBoxSites
  def self.init
    sites = DevBoxConf.settings('sites')

    return if sites.nil?

    if sites.to_s.length.zero?
      abort 'Check your config file, you have no sites specified.'
    end

    DevBoxSites.clear_sites()

    sites.each do |site_data|
      DevBoxSites.validate(site_data)

      DevBoxSites.configure_site(site_data)
    end

    DevBoxSites.restart_web_servers()
  end

  protected
  def self.configure_site(site_data)
    server_root      = site_data['server_root']
    server_root_path = ''

    if server_root != 'none'
      server_root_path = server_root['guest_directory']
      DevBoxFolders.sync_folder(server_root)
    end

    web_server      = site_data['web_server']
    server_tpl      = site_data['server_tpl']
    server_name     = site_data['server_name']
    tpl_source      = File.expand_path(DevBoxConf.vagrant_dir + '/resources/' + server_tpl)
    tpl_destination = '/etc/' + web_server + '/sites-available/' + server_name + '.conf';
    DevBoxFiles.sync_file({
        "host"   => tpl_source,
        "guest"  => tpl_destination,
        "sync"   => "always",
        "options"=> {
            "user" => "root",
            "group"=> "root",
            "mode" => 644
        }
    })

    http_port        = site_data['http_port'] ||= 80
    https_port       = site_data['https_port'] ||= 443
    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/' + web_server + '/create-site.sh')
    script_args      = [
      server_name, server_root['guest_directory'] || 'none' , http_port, https_port
    ]

    DevBoxScript.run_on_guest(script_full_path, script_args, "always")
  end

  protected
  def self.clear_sites
    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/nginx/clear-sites.sh')
    DevBoxScript.run_on_guest(script_full_path, nil, "always")

    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/apache2/clear-sites.sh')
    DevBoxScript.run_on_guest(script_full_path, nil, "always")
  end

  protected
  def self.restart_web_servers
    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/apache2/restart-service.sh')
    DevBoxScript.run_on_guest(script_full_path, nil, "always")

    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/nginx/restart-service.sh')
    DevBoxScript.run_on_guest(script_full_path, nil, "always")
  end

  protected
  def self.validate(site_data)
    if ! site_data['server_name']
      abort 'Check your config file, Site server_name not specified.'
    end

    if ! site_data['server_root']
      abort 'Check your config file, Site server_root settings not specified.'
    end

    if ! site_data['web_server'] && site_data['web_server']!='none'
      abort 'Check your config file, Site web_server not specified.'
    end

    if ! ["apache2", "nginx"].include? site_data['web_server']
      abort 'Check your config file, invalid web_server is specified.'
    end
  end
end
