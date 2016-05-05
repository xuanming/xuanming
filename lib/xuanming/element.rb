module Xuanming
  class Element
    attr_accessor :group
    attr_accessor :id

    # original data
    attr_accessor :metadata
    attr_accessor :data

    def initialize(group, id)
      @group = group
      @id = id

      @ready = false

      @metadata = { type: Set.new }
    end

    def unique_id
      [@group, @id]
    end

    def checksum
      @data.hash
    end

    def ready?
      @ready
    end
  end
end
