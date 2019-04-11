require './lib/devboxconf.rb'

class DevBoxKeys
  def self.sync
    keys = DevBoxConf.settings('keys')

    return if keys.nil?

    if keys.to_s.length.zero?
      abort 'Check your config.json file, you have no keys specified.'
    end

    keys.each do |key|
      key_path = File.expand_path(key)

      DevBoxKeys.validate(key_path)

      DevBoxKeys.sync_key(key_path)
    end
  end

  protected
  def self.sync_key(key_path)
    DevBoxConf.config.vm.provision 'shell', run: "always" do |s|
      s.privileged = false
      s.inline = "echo \"$1\" > /home/vagrant/.ssh/$2 && chmod 600 /home/vagrant/.ssh/$2"
      s.args = [File.read(File.expand_path(key_path)), key_path.split('/').last]
    end
  end

  protected
  def self.validate(key_path)
    return if File.exist? key_path

    abort 'key not found: ' + key_path
  end
end
