module Auditd
  module Ausearch
    module Parser
      class << self
        AUSEARCH_GROUP_DELIMITER = '----'

        def parse(filename)
          result = []
          current_group = Auditd::Ausearch::Group.new
          parse_state = :looking_for_delimiter

          File.open(filename, 'r') do |f|
            f.lines.take(10).each do |line|
              stripped_line = line.strip

              case parse_state
              when :looking_for_delimiter
                if stripped_line == AUSEARCH_GROUP_DELIMITER
                  parse_state = :looking_for_ausearch_items
                end
              when :looking_for_ausearch_items
                if stripped_line == AUSEARCH_GROUP_DELIMITER
                  parse_state = :looking_for_ausearch_items
                else
                  type_string = stripped_line.split[0]
                  type = type_string.split('=')[-1]
                  item_const_name = "#{type[0]}#{type[1..-1].downcase}"

                  item_class = Auditd::Ausearch::Items.const_get(item_const_name)
                  item_class.initialize_from_auditd_syscall_line(stripped_line)
                end
              end
            end
          end

          result
        end
      end
    end
  end
end
