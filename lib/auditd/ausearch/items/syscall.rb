module Auditd
  module Ausearch
    module Items
      class Syscall
        # FIXME: combine this into one include
        include Auditd::Ausearch::Item
        extend Auditd::Ausearch::Item::ClassMethods

        class << self
          def initialize_from_auditd_syscall_line(string)
            demodulized_string = name.split('::')[-1]
            substring = string[(5 + demodulized_string.size + 1)..-1]

            msg_string, attr_string = substring.split(' : ')
            puts attr_string
            #puts string.split(' : ')[0]
          end
        end

        def initialize
        end
      end
    end
  end
end
