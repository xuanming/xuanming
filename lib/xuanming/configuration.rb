require 'yaml'

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/deep_merge'

module Xuanming
  class Configuration
    AVAILABLE_CONFIG = [:env, :log, :extension, :main, :tangram, :transformer]

    def initialize
      @config = Hash[AVAILABLE_CONFIG.map {|c| [c, {}]}]
    end

    def load(config_file)
      @config_origin = YAML.load_file(config_file).deep_symbolize_keys()
      @config.deep_merge! @config_origin.select {|key, _| AVAILABLE_CONFIG.include? key}
    end

    def config(name)
      @config[name]
    end

    AVAILABLE_CONFIG.each do |name|
      define_method(name) do
        @config[name]
      end
    end
  end
end
