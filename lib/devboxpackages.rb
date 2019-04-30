require './lib/devboxscript.rb'

class DevBoxPackages
  def self.install_packages()
    DevBoxPackages.update_upgrade()
    DevBoxPackages.install()
    DevBoxPackages.autoremove()
  end

  protected
  def self.update_upgrade()
    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/update-upgrade.sh')
    DevBoxScript.run_on_guest(script_full_path, nil, "always")
  end

  protected
  def self.autoremove()
    script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/misc/autoremove.sh')
    DevBoxScript.run_on_guest(script_full_path, nil, "always")
  end

  protected
  def self.install()
    scripts_to_run = [
      'installers/initial-setup.sh',
      'installers/install-zip-unzip.sh',
      'installers/install-avahi.sh',
      'installers/install-git.sh',
      'installers/install-mysql-8.sh',
      'installers/install-postgresql-9.sh',
      'installers/install-sqlite-3.sh',
      'installers/install-redis.sh',
      'installers/install-apache2.sh',
      'installers/install-nginx.sh',
      'installers/install-nodejs-10.sh',
      'installers/install-yarn.sh',
      'installers/install-php.sh',
      'installers/install-phpunit-6.5.sh',
      'installers/install-php-composer.sh',
      # 'installers/install-xdebug.sh',
      'installers/install-wp-cli.sh',
      'installers/install-vim.sh',
      'installers/install-go.sh',
      'installers/install-mailutils.sh',
      'installers/install-mailhog.sh'
    ]

    scripts_to_run.each do |script|
      script_full_path = File.expand_path(DevBoxConf.vagrant_dir + '/scripts/' + script)
      DevBoxScript.run_on_guest(script_full_path, nil, "always")
    end
  end
end
