module Xuanming
  class Element
    attr_accessor :label
    attr_accessor :data

    def initialize()
      @label = nil
      @data = nil
    end

    def checksum
      @data.hash
    end

    def ready?
      !@data.nil?
    end
  end

  class ElementPool
    def initialize
      @elements = []
    end

    def <<(element)
      @elements << element
    end
  end
end
