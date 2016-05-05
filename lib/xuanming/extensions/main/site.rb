module Xuanming
  module Extensions
    module Main

      class Site
        def weave(em)
          puts 'site weave...'

          dag = DAG.new

          eg_page_data = ElementGroup.new(:page_data)
          eg_html = ElementGroup.new(:html)

          element_layout = em.group(:layout).element('layout.tpl')
          dag.add_vertex element_layout.unique_id

          em.group(:content).each do |id, e|
            element_page_data = Element.new(:page_data, e.id)
            element_page_data.metadata[:type] << :data

            element_html = Element.new(:html, e.id)
            element_html.metadata[:type] << :final

            eg_page_data.add element_page_data
            eg_html.add element_html

            dag.add_vertex e.unique_id
            dag.add_vertex element_page_data.unique_id
            dag.add_vertex element_html.unique_id
            dag.add_edge element_page_data.unique_id, e.unique_id
            dag.add_edge element_html.unique_id, element_layout.unique_id
            dag.add_edge element_html.unique_id, element_page_data.unique_id
          end

          dag
        end
      end

    end
  end
end
