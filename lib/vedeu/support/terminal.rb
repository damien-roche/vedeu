module Vedeu
  module Terminal
    extend self

    # @param mode [Symbol]
    # @param block [Proc]
    # @return []
    def open(mode, &block)
      @mode = mode

      if block_given?
        if raw_mode?
          console.raw    { initialize_screen { yield } }

        else
          console.cooked { initialize_screen { yield } }

        end
      end
    ensure
      restore_screen
    end

    # @return [String]
    def input
      if raw_mode?
        keys = console.getch
        if keys.ord == 27
          keys << console.read_nonblock(3) rescue nil
          keys << console.read_nonblock(2) rescue nil
        end
        keys

      else
        console.gets.chomp

      end
    end

    # @param stream [String]
    # @return [String]
    def output(stream = '')
      console.print(stream)

      stream
    end

    # @param block [Proc]
    # @return []
    def initialize_screen(&block)
      output Esc.string 'screen_init'

      yield
    end

    # @return [String]
    def clear_screen
      output Esc.string 'clear'
    end

    # @return [String]
    def restore_screen
      output Esc.string 'screen_exit'
      output clear_last_line
    end

    # @return [String]
    def set_cursor_mode
      output Esc.string 'show_cursor' unless raw_mode?
    end

    # @return [Boolean]
    def raw_mode?
      @mode == :raw
    end

    # @return [String]
    def clear_last_line
      Esc.set_position((height - 1), 1) + Esc.string('clear_line')
    end

    # @return [Fixnum]
    def colour_mode
      Configuration.options[:colour_mode]
    end

    # Returns a coordinate tuple of the format [y, x], where `y` is the row/line
    # and `x` is the column/character.
    #
    # @return [Array]
    def centre
      [(height / 2), (width / 2)]
    end

    # Returns the `y` (row/line) component of the coordinate tuple provided by
    # {Terminal.centre}
    #
    # @return [Fixnum]
    def centre_y
      centre.first
    end

    # Returns the `x` (column/character) component of the coodinate tuple
    # provided by {Terminal.centre}
    #
    # @return [Fixnum]
    def centre_x
      centre.last
    end

    # @return [Fixnum] The total width of the current terminal.
    def width
      size.last
    end

    # @return [Fixnum] The total height of the current terminal.
    def height
      size.first
    end

    # @return [Array]
    def size
      console.winsize
    end

    # @return [File]
    def console
      IO.console
    end
  end
end
