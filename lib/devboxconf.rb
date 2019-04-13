require 'json'

class DevBoxConf
  def self.init(config)
    DevBoxConf.config      = config
    DevBoxConf.vagrant_dir = File.expand_path(Dir.pwd)
    DevBoxConf.home_dir    = File.expand_path("~")

    settings_file = File.expand_path(DevBoxConf.vagrant_dir + '/config.json')
    if !File.exist? settings_file then
      abort "Config file not found"
    end

    settings = JSON::parse(File.read(settings_file))
    DevBoxConf.settings = settings
  end

  @@config = nil

  def DevBoxConf.config= (value)
    @@config = value
  end

  def DevBoxConf.config
    return @@config
  end

  @@vagrant_dir = nil

  def DevBoxConf.vagrant_dir= (value)
    @@vagrant_dir = value
  end

  def DevBoxConf.vagrant_dir
    return @@vagrant_dir
  end

  @@home_dir = nil

  def DevBoxConf.home_dir= (value)
    @@home_dir = value
  end

  def DevBoxConf.home_dir
    return @@home_dir
  end

  @@settings = nil

  def DevBoxConf.settings= (value)
    @@settings = value
  end

  def DevBoxConf.settings(key=nil, default_value=nil)
    return @@settings if key.nil?

    return @@settings[key] || default_value
  end
end
