module Vedeu
  class Terminal
    class << self
      def size
        new.size
      end

      def width
        new.width
      end

      def height
        new.height
      end
    end

    def size
      { width: width, height: height }
    end

    def width
      dimensions[1]
    end

    def height
      dimensions[0]
    end

    private

    def dimensions
      IO.console.winsize
    end
  end
end
