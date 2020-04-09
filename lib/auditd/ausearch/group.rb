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

      def syscall
        @syscall ||= @items.find { |i| i.is_a?(Auditd::Ausearch::Items::Syscall) }
      end

      def sockaddr
        @sockaddr ||=
          if syscall.accept4?
            @items.find { |i| i.is_a?(Auditd::Ausearch::Items::Sockaddr) }
          end
      end
    end
  end
end
