module Xuanming
  class Transformer
    class << self
      def transform(data_element)
        data_source = load_data_source
        destination = yyy
        converter = get_converter(data_source.type, destination)
        converter.convert
      end
    end
  end
end
