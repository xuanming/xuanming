module Xuanming
  class Application
    DEFAULT_CONFIG_NAME = 'config.xm'

    attr_accessor :env
    attr_accessor :dep_chain

    def initialize
    end

    def run(args)
      find_app_config
      puts "app root #{@app_root}"
      puts "config file: #{@config_file}"

      load_config
      load_extension
      execute_command(args)
    end


    def load_config
    end

    def load_extension
      Extension.auto_require File.expand_path('../extensions', __FILE__)
    end

    def execute_command(args)
      cmd = Extension.load_extension(Command, args[0])
      cmd.execute
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

      @app_root = search_dir
      @config_file = config_abs_path
    end
  end
end
