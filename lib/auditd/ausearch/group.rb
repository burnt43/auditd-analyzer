module Auditd
  module Ausearch
    class Group
      class << self
      end

      def initialize
        @items = []
      end

      def push(item)
        @items.push(item)
      end

      def empty?
        @items.empty?
      end
    end
  end
end
