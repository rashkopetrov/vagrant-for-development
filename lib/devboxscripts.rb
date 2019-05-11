require './lib/devboxconf.rb'
require './lib/devboxscript.rb'

class DevBoxScripts
  def self.init
    scripts = DevBoxConf.settings('scripts')

    return if scripts.nil?

    if scripts.to_s.length.zero?
      abort 'Check your config.json file, you have no scripts specified.'
    end

    scripts.each do |script_data|
      DevBoxScripts.run_script(script_data)
    end
  end

  protected
  def self.run_script(script_data)
    if script_data.is_a? String then
      script_path = script_data
      script_args = nil
    else
      script_path = script_data["path"]
      script_args = script_data["args"]
    end

    script_full_path = File.expand_path(script_path)
    DevBoxScript.run_on_guest(script_full_path, script_args, "always" )
  end
end
