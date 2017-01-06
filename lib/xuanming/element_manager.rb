require 'xuanming/logger'
require 'xuanming/dag'

module Xuanming
  class ElementManager
    def initialize
      @elements = []

      @indexes = {}

      @dag = DAG.new

      @endpoints = []
    end

    def add(tuple, id, step)
      name = element_group.name
      @tuples[name] = element_group
    end

    def group(name)
      @tuples[name]
    end

    def print
      logger = Logger[:default]
      logger.debug { @tuples }
    end
  end
end
