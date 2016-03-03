module Xuanming
  module Extensions
    module Converter

      class Yaml2Hash
        def match?(input_type, output_type)
          input_type == 'yaml' && output_type == 'hash'
          input_location == 'file' && output_location == 'memory'
        end

        def convert(input)
        end
      end

    end
  end
end
