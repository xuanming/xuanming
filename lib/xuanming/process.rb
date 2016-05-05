module Xuanming
  class Process
    def initialize(config)
      @em = ElementManager.new

      @config = config
    end

    def prepare_source
      @config.source.each do |group, c|
        source_type   = c[:type]
        source_option = c[:option]

        source_class = Extension.load_extension(Extensions::Source, source_type)
        source = source_class.new(group, source_option, @config.env)

        @em.add source.collect
      end
      @em.print
    end

    def weave
      @config.main.each do |main, c|
        main_type   = c[:type]
        main_option = c[:option]
        main_source = c[:source]

        main_class = Extension.load_extension(Extensions::Main, main_type)
        main = main_class.new(main_option, @config.env)

        @dep_graph = main.weave(@em)
      end
    end

    def build_element_flow
      @dep_graph
    end
  end
end
