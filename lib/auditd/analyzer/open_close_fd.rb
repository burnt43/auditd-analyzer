module Auditd
  module Analyzer
    class OpenCloseFd
      def initialize(options={})
        @options = options
      end

      def run!
        groups = Auditd::Ausearch::Parser.parse(ausearch_file)
        fd_map =
          groups.each_with_object({}) do |group, hash|
            if group.syscall.accept4? || group.syscall.close?
              (hash[group.syscall.file_descriptor] ||= []).push(group.syscall)
            end
          end
        
        fd_map.each do |fd, syscalls|
          fd_state = nil

          syscalls.each do |syscall|
            if syscall.accept4?
              if fd_state == :opened
                puts "[\033[0;33mWARNING\033[0;0m] - <fd: #{fd}> opened without being closed"
              end

              fd_state = :opened
            elsif syscall.close?
              if fd_state == :opened
                puts "[\033[0;32mOK\033[0;0m] - <fd: #{fd}> successfully closed"
              end
              fd_state = :closed
            end
          end
        end
      end

      private
      
      def ausearch_file
        @options[:ausearch_file]
      end
    end
  end
end
