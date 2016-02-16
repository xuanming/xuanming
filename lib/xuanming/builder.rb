module Xuanming
  class Builder
    class << self
      def build
        config = Configuration::config
#        Transformer::transform
        puts config
      end
    end
  end
end
