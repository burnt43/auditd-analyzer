module Auditd
  module Ausearch
    module Items
      class Syscall
        # FIXME: combine this into one include
        include Auditd::Ausearch::Item
        extend  Auditd::Ausearch::Item::ClassMethods
      end
    end
  end
end