module Xuanming
  module Extensions
    module Command

      class Builder
        def execute(args, config)
          puts 'in builder execute...'

          builder = Xuanming::Builder.new(config)
          builder.build
        end
      end

    end
  end
end
