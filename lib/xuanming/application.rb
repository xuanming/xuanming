module Xuanming
  class Application
    def initialize
      @config = Configuration.new
    end

    def prepare()
      app_main = @config.find_app_main(Dir.pwd)
      @config.setup_env :app_root, File.expand_path('..', app_main)

      @config.load_app_main

      load_extension
    end

    def run_command(args)
      execute_command(args[0], args[1..-1])
    end


    def load_extension
      Extension.auto_require File.expand_path('../extensions', __FILE__)
    end

    def execute_command(sub_command, args)
      cmd = Extension.load_extension(Extensions::Command, sub_command).new
      cmd.execute(args, @config)
    end
  end
end
