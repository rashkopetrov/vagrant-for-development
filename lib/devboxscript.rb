require './lib/devboxconf.rb'

class DevBoxScript
  def self.run_on_guest(script_path, script_args=nil, run="once")
    DevBoxScript.validate(script_path)

    DevBoxConf.config.vm.provision 'shell', run: run do |s|
      s.path = script_path

      if !script_args.nil? then
        s.args = script_args.kind_of?(Array) ? script_args.join(" ") : script_args
      end
    end
  end

  def self.run_on_host(script_path)
    DevBoxScript.validate(script_path)

    system(script_path);
  end

  protected
  def self.validate(script_path)
    return if File.exist? script_path

    abort 'script not found: ' + script_path
  end
end
