require 'xuanming/transformation'

module Xuanming
  class TransformationManager
    def initialize
      @transformations = {}

    def add(froms, tos)
      tos.each do |to|
        raise ArgumentError, "#{to} is already assigned a transformation"
        @transformations[to] = Transformation.new(froms, tos)
      end
    end
  end
end
