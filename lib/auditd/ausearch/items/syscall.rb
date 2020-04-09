module Auditd
  module Ausearch
    module Items
      class Syscall
        # FIXME: combine this into one include
        include Auditd::Ausearch::Item
        extend  Auditd::Ausearch::Item::ClassMethods

        # data access methods
        def type
          @attribute_hash[:syscall]
        end

        def exit_code
          @attribute_hash[:exit].to_i
        end

        def a0
          @attribute_hash[:a0].to_i(16)
        end

        # type query methods
        def accept4?
          type == 'accept4'
        end

        def close?
          type == 'close'
        end

        # ? methods
        def file_descriptor
          case type
          when 'accept4'
            exit_code
          when 'close'
            a0
          end
        end
      end
    end
  end
end
