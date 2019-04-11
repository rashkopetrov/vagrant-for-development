require './lib/devboxconf.rb'

class DevBoxPorts
  def self.forward
    ports = DevBoxConf.settings('ports')

    return if ports.nil?

    if ports.to_s.length.zero?
      abort 'Check your config.json file, you have no ports specified.'
    end

    ports.each do |port_data|
      DevBoxPorts.forward_port(port_data)
    end
  end

  protected
  def self.forward_port(port_data)
    DevBoxConf.config.vm.network 'forwarded_port', guest: port_data['guest'], host: port_data['host'], protocol: port_data['protocol'], auto_correct: port_data['auto_correct']
  end
end
