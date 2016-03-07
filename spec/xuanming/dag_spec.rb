require 'spec_helper'

describe Xuanming::DAG do
  describe 'with a complex example' do
    before :each do
      @dag = Xuanming::DAG.new
      @dag.add_vertex 3
      @dag.add_vertex 'c'
      @dag.add_vertex [5, 'ef']
      @dag.add_vertex({s: 'g'})
      @dag.add_vertex 15
      @dag.add_edge 3, 'c'
      @dag.add_edge 'c', [5, 'ef']
      @dag.add_edge 'c', 15
      @dag.add_edge 'c', {s: 'g'}
      @dag.add_edge 3, [5, 'ef']
      @dag.add_edge [5, 'ef'], {s: 'g'}
    end

    it 'has the right vertex number' do
      expect(@dag.vertex_size).to eql 5
    end

    it 'has the right edge number' do
      expect(@dag.edge_size).to eql 6
    end

    it 'has the right start vertices' do
      expect(@dag.all_starts).to eql Set.new([3])
    end

    it 'has the right terminal vertices' do
      expect(@dag.all_terminals).to eql Set.new([{s: 'g'}, 15])
    end
  end
end
