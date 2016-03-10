module Xuanming
  class Element
    attr_accessor :group
    attr_accessor :id

    # original data
    attr_accessor :storage_type
    attr_accessor :data_types
    attr_accessor :data

    def initialize(group, id)
      @group = group
      @id = id

      @data_types = []
    end

    def checksum
      @data.hash
    end
  end
end
