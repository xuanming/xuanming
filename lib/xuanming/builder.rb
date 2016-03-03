module Xuanming
  class Builder
    def initialize(config)
      @config = config
    end

    def build
      process = Process.new(@config)

      process.prepare_source
      process.weave
      process.build_element_flow
    end
  end
end
