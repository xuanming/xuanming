module Xuanming
  class ElementGroup
    attr_accessor :name

    def initialize(name)
      @group = {}

      @name = name
    end

    def add(element)
      @group[element.id] = element
    end

    def element(id)
      @group[id]
    end

    def each
      @group.each_value
    end
  end
end
