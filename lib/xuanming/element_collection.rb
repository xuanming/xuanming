module Xuanming
  class ElementCollection
    attr_accessor :name

    def initialize(name)
      @collection = {}

      @name = name
    end

    def add(element)
      @collection[element.id] = element
    end
  end
end
