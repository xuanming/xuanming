module Xuanming
  module Extensions
    module Command

      class Version
        def execute(args, config)
          puts "xuanming #{Xuanming::VERSION}"
        end
      end

    end
  end
end
