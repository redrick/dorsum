module Dorsum
  class Configuration
    CONFIG_PATH = %w(config/dorsum.yml /etc/dorsum.yml).freeze

    attr_accessor :yaml

    def initialize
      CONFIG_PATH.each do |config|
        next unless File.exist?(config)
        self.yaml = YAML.load_file(config)
      end
    end

    def databases
      yaml['databases']
    end
  end
end
