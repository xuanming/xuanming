module Xuanming
  class Application
    DEFAULT_CONFIG_NAME = 'config.xm'

    attr_accessor :env
    attr_accessor :dep_chain

    def initialize
      find_app_config
      puts "app root #{@app_root}"
      puts "config file: #{@config_file}"
    end

    def load_config
    end

    def load_extension
    end

    def execute_command
    end


    def prepare_source
    end

    def weave
      # call site controller
    end

    def build_dep_chain
    end

    private

    def find_app_config
      search_dir = Dir.pwd
      while true
        config_abs_path = File.join(search_dir, DEFAULT_CONFIG_NAME)
        break if File.file? config_abs_path

        new_search_dir = File.absolute_path(File.join(search_dir, '..'))
        raise "Config file #{DEFAULT_CONFIG_NAME} not found" if new_search_dir == search_dir

        search_dir = new_search_dir
      end

      @config_file = config_abs_path
      @app_root = search_dir
    end
  end
end
