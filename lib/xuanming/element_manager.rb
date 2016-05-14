require 'xuanming/logger'

module Xuanming
  class ElementManager
    def initialize
      @catagories = {}

      @endpoints = []
    end

    def add(element_group)
      name = element_group.name
      @catagories[name] = element_group
    end

    def group(name)
      @catagories[name]
    end

    def print
      logger = Logger[:default]
      logger.debug { @catagories }
    end
  end
end
