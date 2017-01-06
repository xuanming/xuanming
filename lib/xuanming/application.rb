require 'xuanming/logger'

module Xuanming
  class Application
    DEFAULT_MAIN_NAME = 'xm.yml'

    def initialize
      Logger.new :default, STDOUT

      @config = Configuration.new

      @app_main_file = DEFAULT_MAIN_NAME
    end

    def prepare()
      app_main = find_app_main(Dir.pwd)
      @config.env[:app_root] = File.expand_path('..', app_main)

      @config.load app_main

      load_extension
    end

    def run_command(args)
      execute_command(args[0], args[1..-1])
    end

    private

    def find_app_main(search_dir)
      while true
        abs_path = File.join(search_dir, @app_main_file)
        break if File.file? abs_path

        new_search_dir = File.absolute_path(File.join(search_dir, '..'))
        if new_search_dir == search_dir
          raise RuntimeError, "App main file #{@app_main_file} not found"
        end

        search_dir = new_search_dir
      end

      @app_main_file = abs_path
    end

    def load_extension
      Extension.auto_require File.expand_path('../extensions', __FILE__)
    end

    def execute_command(sub_command, args)
      cmd = Extension.load_extension(Extensions::Command, sub_command).new
      cmd.execute(args, @config)
    rescue => e
      logger = Logger[:default]
      logger.exception e
    end
  end
end
