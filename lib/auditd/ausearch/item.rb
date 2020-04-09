module Auditd
  module Ausearch
    module Item
      def initialize(attribute_hash)
        @attribute_hash = attribute_hash
      end

      module ClassMethods
        def initialize_from_auditd_syscall_line(string)
          attributes = {}

          # strip of the initial 'type=XYZ' string
          demodulized_string = name.split('::')[-1]
          substring = string[(5 + demodulized_string.size + 1)..-1]

          # since 'msg' is the only attr that has spaces in it and messes
          # up our later regex and it is the first attr we can find it
          # and process it on its own while processing all others.
          msg_string, attr_string = substring.split(' : ')

          # find msg name and value
          msg_attr_name, msg_attr_value = msg_string.split('=')
          attributes[msg_attr_name.to_sym] = msg_attr_value

          # find all other name and value pairs with a regex
          attr_string.scan(/\s\w+=\S+/) do |match|
            stripped_match = match.strip
            attr_name, value = stripped_match.split('=')

            attributes[attr_name.to_s] = value
          end

          new(attributes)
        end
      end
    end
  end
end
