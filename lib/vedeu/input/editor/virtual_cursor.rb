module Vedeu

  module Editor

    # Maintains a cursor position within the Vedeu::Editor::Document class.
    #
    class VirtualCursor

      # @!attribute [rw] bx
      # @return [Fixnum]
      attr_accessor :bx

      # @!attribute [rw] by
      # @return [Fixnum]
      attr_accessor :by

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_accessor :x

      # @!attribute [rw] y
      # @return [Fixnum]
      attr_accessor :y

      # Returns a new instance of Vedeu::Editor::VirtualCursor.
      #
      # @param y [Fixnum] The current line.
      # @param x [Fixnum] The current character with the line.
      # @param by [Fixnum]
      # @param bx [Fixnum]
      # @return [Vedeu::Editor::VirtualCursor]
      def initialize(y: 0, x: 0, by: 1, bx: 1)
        @y  = (y.nil? || y < 0) ? 0 : y
        @x  = (x.nil? || x < 0) ? 0 : x
        @by = by
        @bx = bx
      end

      # Move the virtual cursor to the beginning of the line.
      #
      # @return [Fixnum]
      def bol
        @x = 0
      end

      # Move the virtual cursor down by one line.
      #
      # @return [Fixnum]
      def down
        @y += 1
      end

      # Move the virtual cursor to the left.
      #
      # @return [Fixnum]
      def left
        @x -= 1
      end

      # Move the virtual cursor to the right.
      #
      # @return [Fixnum]
      def right
        @x += 1
      end

      # Return the escape sequence for setting the cursor position and show the
      # cursor.
      #
      # @return [String]
      def to_s
        "\e[#{real_y};#{real_x}H\e[?25h"
      end

      # Move the virtual cursor up by one line.
      #
      # @return [Fixnum]
      def up
        @y -= 1
      end

      private

      # Return the real y coordinate.
      #
      # @return [Fixnum]
      def real_y
        by + y
      end

      # Return the real x coordinate.
      #
      # @return [Fixnum]
      def real_x
        bx + x
      end

    end # VirtualCursor

  end # Editor

end # Vedeu
