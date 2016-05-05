# Do NOT use this
module Xuanming
  class ElementDAG
    def initialize(element_manager)
      @dag = DAG.new
      @em = element_manager
    end

    def add_vertex(element)
      @dag.add_vertex(ElementDAG.element_to_vertex(element))
    end

    def add_edge(from, to)
      @dag.add_edge(ElementDAG.element_to_vertex(from), ElementDAG.element_to_vertex(to))
    end

    private

    def self.element_to_vertex(element)
      [element.group, element.id]
    end
  end
end
