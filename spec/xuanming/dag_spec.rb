require 'spec_helper'

describe Xuanming::DAG do
  describe 'with a complex example' do
    let(:new_dag) do
      dag = Xuanming::DAG.new
      dag.add_vertex 0
      dag.add_vertex 3
      dag.add_vertex 678
      dag.add_vertex 679
      dag.add_edge 0, 3
      dag.add_edge 0, 679
      dag
    end

    before :each do
      @dag = Xuanming::DAG.new
      @dag.add_vertex 3
      @dag.add_vertex 'c'
      @dag.add_vertex [5, 'ef']
      @dag.add_vertex({s: 'g'})
      @dag.add_vertex 15
      @dag.add_vertex 678
      @dag.add_vertex 679
      @dag.add_edge 3, 'c'
      @dag.add_edge 'c', [5, 'ef']
      @dag.add_edge 'c', 15
      @dag.add_edge 'c', {s: 'g'}
      @dag.add_edge 678, 679
      @dag.add_edge 3, [5, 'ef']
      @dag.add_edge [5, 'ef'], {s: 'g'}
    end

    it 'raise exception with unknown vertex' do
      expect { @dag.add_edge(3, 'arfs') }.to raise_error(ArgumentError, /does not belong to DAG/)
      expect { @dag.add_edge(234, 'c') }.to raise_error(ArgumentError, /does not belong to DAG/)
      expect { @dag.add_edge(234, 'arfs') }.to raise_error(ArgumentError, /does not belong to DAG/)
      expect { @dag.predecessors(234) }.to raise_error(ArgumentError, /does not belong to DAG/)
      expect { @dag.successors('ghj') }.to raise_error(ArgumentError, /does not belong to DAG/)
      expect { @dag.sub_graph('oyg') }.to raise_error(ArgumentError, /does not belong to DAG/)
    end

    it 'raise exception if cycle exist' do
      expect { @dag.add_edge({s: 'g'}, 3) }.to raise_error(ArgumentError, /Cycle if add edge/)
      expect { @dag.add_edge(15, 15) }.to raise_error(ArgumentError, /Cycle if add edge/)
      expect { @dag.add_edge(679, 678) }.to raise_error(ArgumentError, /Cycle if add edge/)
    end

    it 'has the right vertex number' do
      expect(@dag.vertex_size).to eq 7
    end

    it 'has the right edge number' do
      expect(@dag.edge_size).to eq 7
    end

    it 'has the right start vertices' do
      expect(@dag.all_starts).to eq Set.new([3, 678])
    end

    it 'has the right terminal vertices' do
      expect(@dag.all_terminals).to eq Set.new([{s: 'g'}, 679, 15])
    end

    it 'has the right predecessors' do
      expect(@dag.predecessors([5, 'ef'])).to eq Set.new(['c', 3])
    end

    it 'has the right successors' do
      expect(@dag.successors('c')).to eq Set.new([{s: 'g'}, 15, [5, 'ef']])
    end

    it 'has the right sub graph' do
      sub_dag = @dag.sub_graph('c')
      expect(sub_dag.vertex_size).to eq 4
      expect(sub_dag.edge_size).to eq 4
      expect(sub_dag.all_starts).to eq Set.new(['c'])
      expect(sub_dag.all_terminals).to eq Set.new([{s: 'g'}, 15])

      sub_dag = @dag.sub_graph({s: 'g'})
      expect(sub_dag.vertex_size).to eq 1
      expect(sub_dag.edge_size).to eq 0
      expect(sub_dag.all_starts).to eq Set.new([{s: 'g'}])
      expect(sub_dag.all_terminals).to eq Set.new([{s: 'g'}])
    end

    describe 'reverse dag' do
      it '#reverse' do
        dag = @dag.clone
        dag_reverse = dag.reverse
        expect(dag.graph).to eq @dag.graph
        expect(dag_reverse.all_starts).to eq dag.all_terminals
        expect(dag_reverse.all_terminals).to eq dag.all_starts
      end

      it '#reverse!' do
        dag = @dag.clone
        dag.reverse!
        expect(dag.all_starts).to eq @dag.all_terminals
        expect(dag.all_terminals).to eq @dag.all_starts
      end
    end

    describe 'operate dag' do
      it '#merge!' do
        new_dag.merge! @dag
        expect(new_dag.all_starts).to eq Set.new([0, 678])
        expect(new_dag.all_terminals).to eq Set.new([{s: 'g'}, 679, 15])
      end

      it '#add_common_predecessor!' do
        @dag.add_common_predecessor!('k')
        expect(@dag.all_starts).to eq Set.new(['k'])
        expect(@dag.all_terminals).to eq Set.new([{s: 'g'}, 679, 15])
      end
    end
  end
end
