require 'pathname'

module Xuanming
  class Extension
    class << self
      def require_gem(gem_name)
        require gem_name
      end

      def auto_require(ext_dir)
        $:.push File.expand_path(ext_dir)
        Dir.glob(File.join(ext_dir, '**', '*.rb')) do |filename|
          f = Pathname.new(filename).relative_path_from(Pathname.new(ext_dir)).to_s
          require f
        end
      end

      def all_descendants(parent)
				ObjectSpace.each_object(::Class).select { |klass| klass < parent }
      end

      def all_extensions(ext_module)
				ext_module.constants.select {|c| ext_module.const_get(c).is_a? ::Class}
      end

      def load_extension(ext_module, ext_name)
        ext_module.const_get(minus_to_camelcase(ext_name))
      end


      private

      def minus_to_camelcase(minus_word)
        minus_word.split('-').collect(&:capitalize).join
      end
    end
  end
end
