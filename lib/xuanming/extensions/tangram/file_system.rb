module Xuanming
  module Extensions
    module Tangram

      class FileSystem
        def initialize(group, option, env)
          @group = group
          @option = option
          @env = env
        end

        def splice
          elements = []

          elements += find_elements(@option['path'])

          elements
        end

        private

        def find_elements(path)
          elements = []
          Array(path).map do |f|
            if File.file?(f)
              e = Element.new
              e.label = { group: @group[:output_file]), id: f }
              e.data = { file_path: File.join(@env[:app_root], f) }
              elements << e
            elsif File.directory?(f)
              elements += dir_elements(f)
            end
          end
        end

        def dir_elements(dir_path)
          abs_dir = File.join(@env[:app_root], @option[:dir])
          Dir.glob(File.join(abs_dir, '**', '*')) do |f|
            if accept_file?(f)
              relative_path = Pathname.new(f).relative_path_from(Pathname.new(abs_dir)).to_s
              element = Xuanming::Element.new(@group, relative_path)
              element.metadata[:type] << :file
              element.data = { abs_path: f }
              ec.add(element)
            end
          end
        end

        def accept_file?(filename)
          return true unless @option[:match]
          Regexp.new(@option[:match]) =~ filename
        end
      end

    end
  end
end
