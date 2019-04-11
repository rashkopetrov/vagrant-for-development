require './lib/devboxconf.rb'

class DevBoxFiles
  def self.sync
    files = DevBoxConf.settings('files')

    return if files.nil?

    if files.to_s.length.zero?
      abort 'Check your config.json file, you have no files specified.'
    end

    files.each do |file_data|
      DevBoxFiles.validate(file_data)

      DevBoxFiles.sync_file(file_data)
    end
  end

  protected
  def self.sync_file(file_data)
    sync = file_data['sync'] ||= "once"
    file_content = File.read(File.expand_path(file_data['host']))
    destination = file_data['guest']

    options = file_data['options'] ||= {}
    user = options['user'] ||= 'vagrant'
    group = options['group'] ||= 'vagrant'
    mode = options['mode'] ||= 644

    DevBoxConf.config.vm.provision 'shell', run: sync do |s|
      s.privileged = true
      s.inline = "echo \"$1\" > $2 && chown $3:$4 $2 && chmod $5 $2"
      s.args = [file_content, destination, user, group, mode]
    end
  end

  protected
  def self.validate(file_data)
    file_path = File.expand_path(file_data['host'])

    return if File.exist? file_path

    abort 'file not found: ' + file_path
  end
end
