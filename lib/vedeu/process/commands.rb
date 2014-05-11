module Vedeu
  module Process
    class Commands
      include Singleton

      class << self
        def instance(&block)
          @instance ||= new(&block)
        end
        alias_method :define, :instance

        def define(name, klass, args = [], options = {})
          instance.define(name, klass, args = [], options = {})
        end

        def execute(command = "")
          instance.execute(command)
        end
      end

      def initialize(&block)
        @commands ||= {}

        yield self if block_given?
      end

      def define(name, klass, args = [], options = {})
        commands.merge!(Command.define(name, klass, args, options))
      end
      alias_method :add, :define

      def execute(command = "")
        commands.fetch(command).call if exists?
      end

      private
      attr_accessor :commands, :instance

      def exists?
        commands.fetch(keys, false)
      end

      # def exit_command
        # @commands ||= { "exit" => Proc.new { puts "Exit called";exit! } }
      # end
    end
  end
end
