module Vedeu

  class PositionValidator

    extend Forwardable

    def_delegators Vedeu::Terminal,
      :tx,
      :ty,
      :txn,
      :tyn

    def_delegators :interface,
      :border?,
      :border,
      :geometry

    def_delegators :border,
      :left?,
      :right?,
      :top?,
      :bottom?

    def_delegators :geometry,
      :left,
      :right,
      :top,
      :bottom

    attr_accessor :x, :y

    def self.validate(interface, x, y)
      new(interface, x, y).validate
    end

    def initialize(interface, x, y)
      @interface = interface
      @x         = x
      @y         = y
    end

    def validate
      Vedeu.log("before_x: #{@x}, before_y: #{@y}")
      terminal_validation
      interface_validation
      border_validation
      Vedeu.log("after_x: #{@x}, after_y: #{@y}")

      self
    end

    private

    attr_reader :interface

    def terminal_validation
      @x = tx  if x < tx
      @x = txn if x > txn
      @y = ty  if y < ty
      @y = tyn if y > tyn
    end

    def interface_validation
      @x = left   if x < left
      @x = right  if x > right
      @y = top    if y < top
      @y = bottom if y > bottom
    end

    def border_validation
      if border?
        @x = left + 1   if left?   && x < (left + 1)
        @x = right - 2  if right?  && x > (right - 2)
        @y = top + 1    if top?    && y < (top + 1)
        @y = bottom - 2 if bottom? && y > (bottom - 2)
      end
    end

  end # PositionValidator

end # Vedeu
