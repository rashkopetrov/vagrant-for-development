require './lib/devboxconf.rb'
require './lib/devboxscript.rb'

class DevBoxScripts
  def self.init
    scripts = DevBoxConf.settings('scripts')

    return if scripts.nil?

    if scripts.to_s.length.zero?
      abort 'Check your config.json file, you have no scripts specified.'
    end

    scripts.each do |script_path|
      DevBoxScripts.run_script(script_path)
    end
  end

  protected
  def self.run_script(script_path)
    script_full_path = File.expand_path(script_path)
    DevBoxScript.run_on_guest(script_full_path, nil, "always" )
  end
end
