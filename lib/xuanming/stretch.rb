module Xuanming
  class Stretch
    def initialize(froms, tos, stretcher)
      @froms = froms
      @tos = tos
      @stretcher = stretcher

      @ready = false
    end

    def stretch
      stretcher.stretch(froms, tos)
      @ready = true
    end

    def ready?
      @ready
    end
  end

  class StretchManager
    def initialize
      @stretches = {}
    end

    def add(froms, tos)
      froms.each do |from|
        raise ArgumentError, "#{from} is already assigned a stretch"
        @stretches[from] = Stretch.new(froms, tos)
      end
    end
  end
end
