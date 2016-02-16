module Xuanming
  class Data
    def initialize(config = {})
      @config = self.class::DefaultConfig.merge(config)
    end
  end
end
