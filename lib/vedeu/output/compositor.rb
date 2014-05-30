module Vedeu
  class Compositor
    class << self
      def arrange(output = [], interface = Dummy)
        return if output.nil? || output.empty?

        new(output, interface).arrange
      end
    end

    def initialize(output = [], interface = Dummy)
      @output, @interface = output, interface
    end

    def arrange
      Renderer.write(composition)
    end

    private

    attr_reader :interface

    def composition
      container = []
      streams = []
      output.map do |line|
        line.each_with_index do |stream, index|
          streams << clear_line(index)
          streams << Directive.enact(stream)
        end
        container << streams.join
        streams = []
      end
      container
    end

    def clear_line(index)
      [position(vy(index), vx), (' ' * width), position(vy(index), vx)].join
    end

    def vx(index = 0)
      geometry.vx(index)
    end

    def vy(index = 0)
      geometry.vy(index)
    end

    def width
      geometry.width
    end

    def geometry
      interface.geometry
    end

    def position(y, x)
      Position.set(y, x)
    end

    def output
      return @output.split if @output.is_a?(String)
      @output
    end
  end
end
