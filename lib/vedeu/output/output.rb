module Vedeu

  # Sends the interface to the terminal or output device.
  #
  class Output

    # Writes content (the provided interface object with associated lines,
    # streams, colours and styles) to the area defined by the interface.
    #
    # @return [Array|String]
    # @see #initialize
    def self.render(interface)
      new(interface).render
    end

    # Return a new instance of Output.
    #
    # @param interface [Interface]
    # @return [Output]
    def initialize(interface)
      @interface = interface
    end

    # Send the view to the terminal.
    #
    # @return [Array]
    def render
      Vedeu.trigger(:_drb_store_output_, virtual_view)

      Terminal.output(view, interface.cursor.to_s)
    end

    private

    attr_reader :interface

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @return [String]
    def clear
      Vedeu.log("Clearing view: '#{interface.name}'")

      interface.height.times.inject([interface.colour]) do |line, index|
        line << interface.origin(index) { ' ' * interface.width }
      end.join
    end

    # Produces a single string which contains all content and escape sequences
    # required to render this interface in the terminal window.
    #
    # @return [String]
    def view
      out = [ clear ]

      Vedeu.log("Rendering view: '#{interface.name}'")

      viewport.each_with_index do |line, index|
        out << interface.origin(index)
        out << line.join
      end

      out.join
    end

    # @note
    #   omg!
    #
    # @return []
    def virtual_clear
      out = []
      interface.height.times do |hi|
        row = []
        interface.width.times do |wi|
          v   = interface.raw_origin(hi)
          pos = Vedeu::Position.new(v.first, (v.last + wi))
          row << Vedeu::Char.new({ value: ' ', parent: nil, colour: interface.colour, style: nil, position: pos })
        end
        out << row
      end
      out
    end

    # Builds up a virtual view; a grid of Vedeu::Char objects- each one holding
    # one character along with its colour, style and position attributes.
    #
    # @note
    #   omg!
    #
    # @return []
    def virtual_view
      out = [ virtual_clear ]

      viewport.each_with_index do |line, line_index|
        row = []
        line.each_with_index do |char, char_index|
          v   = interface.raw_origin(line_index)
          pos = Vedeu::Position.new(v.first, (v.last + char_index))
          row << if char.is_a?(Vedeu::Char)
            char.position=(pos)
            char

          else
            Vedeu::Char.new({ value: char, parent: nil, colour: interface.colour, style: nil, position: pos })

          end
        end
        out << row
      end
      out
    end

    # @return []
    def viewport
      @_viewport ||= Vedeu::Viewport.new(interface).render
    end

  end # Output

end # Vedeu
