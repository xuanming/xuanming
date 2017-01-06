module Xuanming
  class TangramPool
    def initialize(name)
      @tangrams = {}
    end

    def [](name)
      @@tangrams[name]
    rescue KeyError => e
      raise ArgumentError, "Tangram \"#{name}\" not found"
    end

    def []=(name, tangram)
      @tangrams[name] = tangram
    end
  end
end
