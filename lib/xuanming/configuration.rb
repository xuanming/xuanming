require 'yaml'

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/deep_merge'

module Xuanming
  class Configuration
    DEFAULT_MAIN_NAME = 'main.xm'

    def initialize
      @config = {env: {}}
      @app_main_file = DEFAULT_MAIN_NAME
    end

    def load_app_main
      @config.deep_merge! YAML.load_file(@app_main_file).deep_symbolize_keys()
    end

    def setup_env(key, value)
      @config[:env][key] = value
    end

    def env
      @config[:env]
    end

    def source
      @config[:source]
    end

    def main
      @config[:main]
    end

    def find_app_main(search_dir)
      while true
        abs_path = File.join(search_dir, DEFAULT_MAIN_NAME)
        break if File.file? abs_path

        new_search_dir = File.absolute_path(File.join(search_dir, '..'))
        if new_search_dir == search_dir
          raise RuntimeError, "App main file #{DEFAULT_MAIN_NAME} not found"
        end

        search_dir = new_search_dir
      end

      @app_main_file = abs_path
    end
  end
end
