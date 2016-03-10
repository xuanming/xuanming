module Xuanming
  module Extensions
    module Transformer

      class Yaml2Hash
        def self.stable?
          true
        end

        def match?(input_type, output_type)
          input_type == 'yaml' && output_type == 'hash'
          input_location == 'file' && output_location == 'memory'
        end

        def convert(input, helper)
        end
      end

    end
  end
end
