# frozen_string_literal: true

module Vedeu

  module Geometries

    # Geometry allows the configuration of the position and size of an
    # interface. Within Vedeu, as the same for ANSI terminals, has the
    # origin at top-left, y = 1, x = 1. The 'y' coordinate is
    # deliberately first.
    #
    # The Geometry DSL can be used within the Interface DSL or
    # standalone. Here are example of declarations for a `geometry`
    # block:
    #
    # A standalone geometry definition:
    #
    #   Vedeu.geometry :some_interface do
    #     height 5 # Sets the height of the view to 5
    #     width 20 # Sets the width of the view to 20
    #     x 3      # Start drawing 3 spaces from left
    #     y 10     # Start drawing 10 spaces from top
    #     xn 30    # Stop drawing 30 spaces from the left
    #     yn 20    # Stop drawing 20 spaces from top
    #   end
    #
    # An interface including a geometry definition:
    #
    #   Vedeu.interface :some_interface do
    #     geometry do
    #       height 5
    #       width 20
    #       x 3
    #       y 10
    #       xn 30
    #       yn 20
    #     end
    #     # ... some code here
    #   end
    #
    # If a declaration is omitted for `height` or `width` the full
    # remaining space available in the terminal will be used. `x` and
    # `y` both default to 1.
    #
    # You can also make a geometry declaration dependent on another
    # view:
    #
    #   Vedeu.interface :other_panel do
    #     # ... some code here
    #   end
    #
    #   Vedeu.interface :main do
    #     geometry do
    #       height 10
    #       y { use(:other_panel).south }
    #     end
    #     # ... some code here
    #   end
    #
    #
    # This view will begin just below "other\_panel".
    #
    # This crude ASCII diagram represents a Geometry within Vedeu,
    # each of the labels is a value you can access or define.
    #
    #        x    north    xn           # north:  y - 1
    #      y +--------------+           # top:    y
    #        |     top      |           # west:   x - 1
    #        |              |           # left:   x
    #   west | left   right | east      # right:  xn
    #        |              |           # east:   xn + 1
    #        |    bottom    |           # bottom: yn
    #     yn +--------------+           # south:  yn + 1
    #             south
    #
    class DSL

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Geometry
      include Vedeu::DSL::Use

      # Align the interface/view horizontally or vertically within
      # the terminal.
      #
      # {include:file:docs/dsl/by_method/geometry/align.md}
      # @param vertical [Symbol] One of :bottom, :middle, :none, :top.
      # @param horizontal [Symbol] One of :center, :centre, :left,
      #   :none, :right.
      # @param width [Fixnum] The number of characters/columns wide;
      #   this is required when the given value for horizontal is any
      #   value other than :none.
      # @param height [Fixnum] The number of lines/rows tall; this is
      #   required when the given value for vertical is any value
      #   other than :none.
      # @macro raise_invalid_syntax
      # @return [Vedeu::Geometries::Geometry]
      def align(vertical: :none, horizontal: :none, width: nil, height: nil)
        horizontal_alignment(horizontal, width)
        vertical_alignment(vertical, height)
      end

      # @param value [Symbol] One of :center, :centre, :left, :none,
      #   :right.
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometries::Geometry]
      def horizontal_alignment(value = :none, width = nil)
        alignment = Vedeu::Coercers::HorizontalAlignment.validate(value)

        model.width = width if width
        model.horizontal_alignment = alignment
        model
      end

      # @param value [Symbol] One of :bottom, :middle, :none, :top.
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometries::Geometry]
      def vertical_alignment(value = :none, height = nil)
        alignment = Vedeu::Coercers::VerticalAlignment.validate(value)

        model.height = height if height
        model.vertical_alignment = alignment
        model
      end

      # Vertically align the interface/view to the bottom of the
      # terminal.
      #
      #   Vedeu.geometry :some_interface do
      #     # `height` is a positive integer, e.g. 30
      #     align_bottom 30
      #
      #     # this is the same as:
      #     # vertical_alignment(:bottom, 30)
      #
      #     # or you can use: (see notes)
      #     # align(vertical: :bottom, height: 30)
      #
      #     # ... some code
      #   end
      #
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometries::Geometry]
      def align_bottom(height = nil)
        vertical_alignment(:bottom, height)
      end

      # Horizontally align the interface/view centrally.
      #
      #   Vedeu.geometry :some_interface do
      #     # `width` is a positive integer, e.g. 30
      #     align_centre 30
      #
      #     # this is the same as:
      #     # horizontal_alignment(:centre, 30)
      #
      #     # or you can use: (see notes)
      #     # align(horizontal: :centre, width: 30)
      #
      #     # ... some code
      #   end
      #
      #   # Also allows `align_center` if preferred.
      #
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometries::Geometry]
      def align_centre(width = nil)
        horizontal_alignment(:centre, width)
      end
      alias align_center align_centre

      # Horizontally align the interface/view to the left.
      #
      #   Vedeu.geometry :some_interface do
      #     # `width` is a positive integer, e.g. 30
      #     align_left 30
      #
      #     # this is the same as:
      #     # horizontal_alignment(:left, 30)
      #
      #     # or you can use: (see notes)
      #     # align(horizontal: :left, width: 30)
      #
      #     # ... some code
      #   end
      #
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometries::Geometry]
      def align_left(width = nil)
        horizontal_alignment(:left, width)
      end

      # Vertically align the interface/view to the middle of the
      # terminal.
      #
      #   Vedeu.geometry :some_interface do
      #     # `height` is a positive integer, e.g. 30
      #     align_middle 30
      #
      #     # this is the same as:
      #     # vertical_alignment(:middle, 30)
      #
      #     # or you can use: (see notes)
      #     # align(vertical: :middle, height: 30)
      #
      #     # ... some code
      #   end
      #
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometries::Geometry]
      def align_middle(height = nil)
        vertical_alignment(:middle, height)
      end

      # Align the interface/view to the right.
      #
      #   Vedeu.geometry :some_interface do
      #     # `width` is a positive integer, e.g. 30
      #     align_right 30
      #
      #     # this is the same as:
      #     # horizontal_alignment(:right, 30)
      #
      #     # or you can use: (see notes)
      #     # align(horizontal: :right, width: 30)
      #
      #     # ... some code
      #   end
      #
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometries::Geometry]
      def align_right(width = nil)
        horizontal_alignment(:right, width)
      end

      # Vertically align the interface/view to the top of the
      # terminal.
      #
      #   Vedeu.geometry :some_interface do
      #     # `height` is a positive integer, e.g. 30
      #     align_top 30
      #
      #     # this is the same as:
      #     # vertical_alignment(:top, 30)
      #
      #     # or you can use: (see notes)
      #     # align(vertical: :top, height: 30)
      #
      #     # ... some code
      #   end
      #
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometries::Geometry]
      def align_top(height = nil)
        vertical_alignment(:top, height)
      end

      # Returns the width in characters for the number of columns
      # specified.
      #
      #   Vedeu.geometry :main_interface do
      #     # ... some code
      #     width columns(9) # Vedeu.width # => 92 (for example)
      #                      # 92 / 12 = 7
      #                      # 7 * 9 = 63
      #                      # Therefore, width is 63 characters.
      #   end
      #
      # @param value [Fixnum]
      # @macro raise_out_of_range
      # @return [Fixnum|Vedeu::Error::OutOfRange]
      def columns(value)
        Vedeu::Geometries::Grid.columns(value)
      end

      # Specify the number of characters/rows/lines tall the interface
      # will be. This value will be ignored when `y` and `yn` are set.
      #
      #   Vedeu.geometry :some_interface do
      #     height 8
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @return [Fixnum]
      def height(value)
        model.height = proc { value }
      end
      alias height= height

      # Returns the height in characters for the number of rows
      # specified.
      #
      #   Vedeu.geometry :main_interface do
      #     # ... some code
      #     height rows(3)  # Vedeu.height # => 38 (for example)
      #                     # 38 / 12 = 3
      #                     # 3 * 3 = 9
      #                     # Therefore, height is 9 characters.
      #   end
      #
      # @param value [Fixnum]
      # @macro raise_out_of_range
      # @return [Fixnum]
      def rows(value)
        Vedeu::Geometries::Grid.rows(value)
      end

      # Specify the number of characters/columns wide the interface
      # will be. This value will be ignored when `x` and `xn` are set.
      #
      #   Vedeu.geometry :some_interface do
      #     width 25
      #     # ... some code
      #   end
      #
      # @param value [Fixnum] The number of characters/columns.
      # @return [Fixnum]
      def width(value)
        model.width = proc { value }
      end
      alias width= width

      # Specify the starting x position (column) of the interface.
      #
      #   Vedeu.geometry :some_interface do
      #     x 7 # start on column 7.
      #
      #     # start on column 8, if :other_interface changes position
      #     # then :some_interface will too.
      #     x { use(:other_interface).east }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def x(value = 1, &block)
        return model.x = block if block_given?

        model.x = value
      end
      alias x= x

      # Specify the ending x position (column) of the interface.
      # This value will override `width`.
      #
      #   Vedeu.geometry :some_interface do
      #     xn 37 # end at column 37.
      #
      #     # when :other_interface changes position,
      #     # :some_interface will too.
      #     xn  { use(:other_interface).right }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def xn(value = 1, &block)
        return model.xn = block if block_given?

        model.xn = value
      end
      alias xn= xn

      # Specify the starting y position (row/line) of the interface.
      #
      #   Vedeu.geometry :some_interface do
      #     y  4 # start at row 4
      #
      #     # start on row/line 3, when :other_interface changes
      #     # position, :some_interface will too.
      #     y  { use(:other_interface).north }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def y(value = 1, &block)
        return model.y = block if block_given?

        model.y = value
      end
      alias y= y

      # Specify the ending y position (row/line) of the interface.
      # This value will override `height`.
      #
      #   Vedeu.geometry :some_interface do
      #     yn 24 # end at row 24.
      #
      #     # if :other_interface changes position, :some_interface
      #     # will too.
      #     yn { use(:other_interface).bottom }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def yn(value = 1, &block)
        return model.yn = block if block_given?

        model.yn = value
      end
      alias yn= yn

    end # DSL

  end # Geometries

  # @!method geometry
  #   @see Vedeu::Geometries::DSL.geometry
  def_delegators Vedeu::Geometries::DSL,
                 :geometry

end # Vedeu
