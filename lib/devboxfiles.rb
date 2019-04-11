require './lib/devboxconf.rb'

class DevBoxFiles
  def self.sync
    files = DevBoxConf.settings('files')

    return if files.nil?

    if files.to_s.length.zero?
      abort 'Check your config.json file, you have no files specified.'
    end

    files.each do |file_data|
      file_path = File.expand_path(file_data['host'])

      DevBoxFiles.validate(file_path)

      DevBoxFiles.sync_file(file_data)
    end
  end

  protected
  def self.sync_file(file_data)
    DevBoxConf.config.vm.provision "file", source: file_data['host'], destination: file_data['guest'], run: file_data['sync']
  end

  protected
  def self.validate(file_path)
    return if File.exist? file_path

    abort 'file not found: ' + file_path
  end
end
