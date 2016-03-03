module Xuanming
  class ElementManager
    def initialize
      @collections = {}
    end

    def add(element_collection)
      name = element_collection.name
      @collections[name] = element_collection
    end

    def print
      puts @collections
    end
  end
end
