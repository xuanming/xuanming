module Xuanming
  class ElementCollection
    attr_accessor :name

    def initialize(name)
      @collection = {}

      @name = name
    end

    def add(index, element)
      @collection[index] = element
    end
  end
end
