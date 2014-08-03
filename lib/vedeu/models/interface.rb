require 'virtus'

require 'vedeu'
require 'vedeu/models/attributes/line_collection'
require 'vedeu/models/colour'
require 'vedeu/models/style'
require 'vedeu/output/clear_interface'
require 'vedeu/output/render_interface'
require 'vedeu/support/geometry'
require 'vedeu/support/queue'
require 'vedeu/support/terminal'

# Todo: mutation (events, current)

module Vedeu
  class Interface
    include Vedeu::Queue
    include Virtus.model

    attribute :name,    String
    attribute :lines,   LineCollection
    attribute :colour,  Colour,  default: Colour.new
    attribute :style,   Style,   default: ''
    attribute :y,       Integer, default: 1
    attribute :x,       Integer, default: 1
    attribute :width,   Integer, default: Terminal.width
    attribute :height,  Integer, default: Terminal.height
    attribute :current, String,  default: ''
    attribute :cursor,  Boolean, default: true
    attribute :centred, Boolean, default: false
    attribute :delay,   Float,   default: 0

    def initialize(attributes = {})
      super

      Vedeu.events.on(:refresh, self.delay) { refresh }

      self
    end

    def clear
      @_clear ||= ClearInterface.call(self)
    end

    def enqueue
      super(self.to_s)
    end

    def geometry
      @_geometry ||= Geometry.new(attributes)
    end

    def origin(index = 0)
      geometry.origin(index)
    end

    def refresh
      if enqueued?
        self.current = dequeue

      elsif no_content?
        self.current = clear

      else
        self.current

      end
      Terminal.output(self.current)

      self.current
    end

    def to_s
      RenderInterface.call(self)
    end

    private

    def no_content?
      self.current.nil? || self.current.empty?
    end
  end
end
