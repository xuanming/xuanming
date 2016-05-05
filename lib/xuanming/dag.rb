require 'set'

module Xuanming
  class DAG
    class << self
      def all_endpoints(graph)
        endpoints = Set.new
        graph.each do |v, e|
          endpoints << v if e.empty?
        end
        endpoints
      end

      def dependencies(graph, vertex)
        unless graph.has_key?(vertex)
          raise ArgumentError, "Vertex #{vertex} does not belong to DAG"
        end
        graph[vertex]
      end

      def has_path_to?(from, to, graph)
        return true if from == to
        graph[from].each do |v|
          return true if DAG.has_path_to?(v, to, graph)
        end
        false
      end
    end


    attr_reader :graph


    def initialize
      @graph = {}
      @graph_reverse = {}
    end


    def add_vertex(vertex)
      unless @graph.has_key?(vertex)
        @graph[vertex] = Set.new
        @graph_reverse[vertex] = Set.new
      end
    end

    def add_edge(from, to)
      unless @graph.has_key?(from) && @graph.has_key?(to)
        raise ArgumentError, "Vertex #{from} or #{to} does not belong to DAG"
      end
      if DAG.has_path_to?(to, from, @graph)
        raise ArgumentError, "Cycle if add edge from #{from} to #{to}"
      end
      @graph[from] << to
      @graph_reverse[to] << from
    end

    def add_vertex_recursive(vertex, graph)
      add_vertex vertex
      graph[vertex].each do |v|
        add_vertex_recursive v, graph
        add_edge vertex, v
      end
    end


################################################################################

    def reverse!
      @graph, @graph_reverse = @graph_reverse, @graph
      self
    end

    def reverse
      dag = self.clone
      dag.reverse!
    end


################################################################################

    def each
      @graph.each_key
    end


################################################################################

    def vertex_size
      @graph.size
    end

    def edge_size
      @graph.inject(0) do |result, (key, value)|
        result += value.size
      end
    end


    def all_starts
      DAG.all_endpoints(@graph_reverse)
    end

    def all_terminals
      DAG.all_endpoints(@graph)
    end


    def predecessors(vertex)
      DAG.dependencies(@graph_reverse, vertex)
    end

    def successors(vertex)
      DAG.dependencies(@graph, vertex)
    end


    def sub_graph(vertex)
      unless @graph.has_key?(vertex)
        raise ArgumentError, "Vertex #{vertex} does not belong to DAG"
      end

      dag = DAG.new
      dag.add_vertex_recursive vertex, @graph
      dag
    end


################################################################################

    def merge!(dag)
      dag.graph.each_key do |v|
        add_vertex v
      end
      dag.graph.each do |v, edges|
        edges.each do |edge|
          add_edge v, edge
        end
      end
    end

    def add_common_predecessor!(vertex)
      starts = all_starts

      add_vertex vertex
      starts.each do |v|
        add_edge vertex, v
      end
    end
  end
end
