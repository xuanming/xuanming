module Xuanming
  module Extensions
    module Source

      class FileSystem
        def initialize(name, option, env)
          @name = name
          @option = option
          @env = env

          @option[:dir] ||= 'content'
          @option[:ext] = @option[:ext] ? Array(@option[:ext]) : []
        end

        def collect
          ec = Xuanming::ElementCollection.new(@name)

          abs_dir = File.join(@env[:app_root], @option[:dir])
          Dir.glob(File.join(abs_dir, '**', '*')) do |f|
            if accept_file?(f)
              relative_path = Pathname.new(f).relative_path_from(Pathname.new(abs_dir)).to_s
              element = Xuanming::Element.new
              element.location = :file
              element.data = f
              ec.add(relative_path, element)
            end
          end

          ec
        end

        private

        def accept_file?(file_name)
          @option[:ext].each do |e|
            return true if file_name.end_with?(e)
          end
          false
        end
      end

    end
  end
end
