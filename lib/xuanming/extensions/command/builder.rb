require 'xuanming/logger'

module Xuanming
  module Extensions
    module Command

      class Builder
        def execute(args, config)
          logger = Logger[:default]
          logger.debug { 'in builder execute...' }

          builder = Xuanming::Builder.new(config)
          builder.build
        end
      end

    end
  end
end
