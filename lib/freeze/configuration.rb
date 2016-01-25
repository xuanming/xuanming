require 'yaml'

module Freeze
  class Configuration
    @@config = {}

    class << self
      def load_config
        @@config = YAML.load_file('freeze.yml')
      end

      def config
        @@config
      end
    end
  end
end
