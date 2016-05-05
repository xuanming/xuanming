module Xuanming
  module Extensions
    module Source

      class FileSystem
        def initialize(group, option, env)
          @group = group
          @option = option
          @env = env

          @option[:dir] ||= 'content'
        end

        def collect
          ec = Xuanming::ElementGroup.new(@group)

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

          ec
        end

        private

        def accept_file?(filename)
          return true unless @option[:match]
          Regexp.new(@option[:match]) =~ filename
        end
      end

    end
  end
end
