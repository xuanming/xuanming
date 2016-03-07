require 'set'

module Xuanming
  class DAG
    def initialize
      @dag = {}
      @indegree = {}
    end

    def add_vertex(vertex)
      unless @dag.has_key?(vertex)
        @dag[vertex] = Set.new
        @indegree[vertex] = 0
      end
    end

    def add_edge(from, to)
      raise Exception unless @dag.has_key?(from) && @dag.has_key?(to)
      @dag[from] << to
      @indegree[to] += 1
    end

    def vertex_size
      @dag.size
    end

    def edge_size
      @dag.inject(0) do |result, (key, value)|
        result += value.size
      end
    end

    def all_starts
      starts = Set.new
      @indegree.each do |v, e|
        starts << v if e == 0
      end
      starts
    end

    def all_terminals
      terminals = Set.new
      @dag.each do |v, e|
        terminals << v if e.empty?
      end
      terminals
    end
  end
end
