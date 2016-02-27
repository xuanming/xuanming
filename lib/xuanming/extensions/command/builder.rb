module Xuanming
  module Command
    class Builder
      def execute
        puts 'in builder execute...'

        process = ::Xuanming::Process.new

        process.prepare_source
        process.weave
        process.build_dep_chain
      end
    end
  end
end
