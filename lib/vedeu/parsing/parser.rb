require 'vedeu/models/composition'
require 'vedeu/parsing/hash_parser'
require 'vedeu/parsing/json_parser'
require 'vedeu/parsing/menu_parser'

module Vedeu
  ParseError = Class.new(StandardError)

  class Parser
    def self.parse(output = {})
      return nil if output.nil? || output.empty?

      new(output).parse
    end

    def initialize(output = {})
      @output = output
    end

    def parse
      Composition.enqueue(parsed_output)
    end

    private

    attr_reader :output

    def parsed_output
      @parsed ||= parser.parse(output)
    end

    def parser
      return JSONParser if json?
      return HashParser if hash?
      return MenuParser if menu?

      fail ParseError, 'Cannot process output from command.'
    end

    def menu?
      output.is_a?(Array)
    end

    def hash?
      output.is_a?(Hash)
    end

    def json?
      output.is_a?(String)
    end
  end
end