require 'vedeu/presentation/presentation'

module Vedeu

  # A Char represents a single character of the terminal. It is a container for
  # the a single character in a {Vedeu::Stream}.
  #
  # Though a multi-character String can be passed as a value, only the first
  # character is returned in the escape sequence.
  #
  # @api private
  #
  class Char

    include Vedeu::Presentation

    attr_accessor :parent,
      :position

    # Returns a new instance of Char.
    #
    # @param attributes [Hash]
    # @option attributes value    [String]
    # @option attributes parent   [Line]
    # @option attributes colour   [Colour]
    # @option attributes style    [Style]
    # @option attributes position [Position]
    # @return [Char]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @colour   = Vedeu::Colour.coerce(@attributes[:colour])
      @parent   = @attributes[:parent]
      @position = Vedeu::Position.coerce(@attributes[:position])
      @style    = @attributes[:style]
      @value    = @attributes[:value]
    end

    # Returns log friendly output.
    #
    # @return [String]
    def inspect
      "<#{self.class.name} (value:'#{@value}')>"
    end

    # @param other []
    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # @param other []
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value
    end

    # @return [String] The character.
    def value
      return '' unless @value

      @value[0]
    end

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        colour:   nil,
        parent:   nil,
        position: nil,
        style:    nil,
        value:    nil,
      }
    end

  end # Char

end # Vedeu
