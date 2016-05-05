require 'xuanming/logger'

module Xuanming
  class ElementManager
    def initialize
      @groups = {}
    end

    def add(element_group)
      name = element_group.name
      @groups[name] = element_group
    end

    def group(name)
      @groups[name]
    end

    def print
      logger = Logger[:default]
      logger.debug { @groups }
    end
  end
end
