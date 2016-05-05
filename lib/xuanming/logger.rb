require 'logger'
require 'colorize'

module Xuanming
  class Logger
    COLORS = {
      'DEBUG' => [:blue,   false],
      'INFO'  => [:green,  false],
      'WARN'  => [:magenta, false],
      'ERROR' => [:red,    false],
      'FATAL' => [false,   :red],
      'ANY'   => [false,   false],
    }

    @@loggers = {}

    def self.[](name)
      @@loggers[name]
    rescue KeyError => e
      raise ArgumentError, "Logger name \"#{name}\" not found"
    end


    def initialize(name, logdev)
      @@loggers[name] = self

      @name = name
      @full_output = true
      @color = true
      @tty = logdev.respond_to?(:isatty) && logdev.isatty

      @logger = ::Logger.new logdev

      @logger.formatter = proc do |severity, datetime, progname, msg|
        if @full_output
          message = "%-7s #{datetime}: #{msg}\n" % "[#{severity}]"
        else
          message = "#{msg}\n"
        end

        if @color && @tty
          fg = self.class::COLORS[severity][0]
          bg = self.class::COLORS[severity][1]
          color = {color: fg, background: bg}
          message.colorize(color)
        else
          message
        end
      end
    end

    [:debug, :info, :warn, :error, :fatal, :unknown].each do |name|
      define_method(name) do |progname = nil, &block|
        @logger.send(name, progname, &block)
      end
    end

    def exception(e)
      @logger.fatal { "Exception (#{e.class}):" }
      @logger.fatal { "  #{e.message}" }

      @logger.fatal { "Backtrace:" }
      @logger.fatal { "  #{e.backtrace[0]}" }
      @logger.fatal { "  ..." }
      @logger.fatal { "  #{e.backtrace[-1]}" }
    end
  end
end
