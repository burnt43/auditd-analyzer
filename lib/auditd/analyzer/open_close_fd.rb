module Auditd
  module Analyzer
    class OpenCloseFd
      def initialize(options={})
        @options = options
      end

      def run!
        groups = Auditd::Ausearch::Parser.parse(ausearch_file)
      end

      private
      
      def ausearch_file
        @options[:ausearch_file]
      end
    end
  end
end
