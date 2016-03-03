module Xuanming
  class Process
    def initialize(config)
      @em = ElementManager.new

      @config = config
    end

    def prepare_source
      @config.source.each do |source_name, c|
        source_type   = c[:type]
        source_option = c[:option]

        source_class = Extension.load_extension(Extensions::Source, source_type)
        source = source_class.new(source_name, source_option, @config.env)

        @em.add source.collect
      end
      @em.print
    end

    def weave
      main_config = @config.main
      main_type   = main_config[:type]
      main_option = main_config[:option]
      main_source = main_config[:source]

      main_class = Extension.load_extension(Extensions::Main, main_type)
      main = main_class.new(main_option, @config.env)

      @dep_graph = main.weave(@em)
    end

    def build_element_flow
    end
  end
end
