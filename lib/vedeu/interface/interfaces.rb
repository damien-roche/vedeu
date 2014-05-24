module Vedeu
  class UndefinedInterface < StandardError; end

  module Interfaces
    extend self
    attr_accessor :interfaces

    def define(&block)
      if block_given?
        yield self
      else
        self
      end
    end

    def defined
      interfaces.empty? ? nil : self
    end

    def default
      add(:dummy, Dummy)
    end

    def list
      interfaces.inspect
    end

    def add(name, klass, options = {})
      if valid?(klass)
        interfaces[name] = Proc.new { klass.new(options) }
        self
      end
    end

    def initial_state
      interfaces.values.map { |io| io.call.initial_state }
    end

    def event_loop
      interfaces.values.map { |io| io.call.event_loop }
    end

    private

    def valid?(klass)
      raise UndefinedInterface unless Object.const_defined?(klass.to_s)
      true
    end

    def interfaces
      @interfaces ||= {}
    end
  end
end
