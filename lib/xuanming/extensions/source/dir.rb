module Xuanming
  module Sources
    class Dir
      DefaultConfig = {
        'Dir' => 'source',
        'Extension' => ['md', 'erb'],
      }

      def each
        @elements.each do |e|
          p e
          yield e
        end
      end

      def analyze
        p "#{@config['Dir']}/**/*"
        @elements = Dir.glob("#{@config['Dir']}/**/*").select do |f|
          accept_file?(f)
        end
      end

      private

      def accept_file?(file_name)
        @config['Extension'].each do |e|
          return true if f.end_with(e)
        end
      end
    end
  end
end
