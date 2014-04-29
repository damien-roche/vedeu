module Vedeu
  module Colours
    class Colour
      class << self
        def set(mask = [])
          new(mask).set
        end

        def reset(mask = [])
          new(mask).reset
        end
      end

      def initialize(mask = [])
        @mask = mask
      end

      def set
        return reset if mask.empty?

        [foreground, background].join
      end

      def reset
        Esc.reset
      end

      private

      attr_reader :mask

      def foreground
        Colours::Foreground.escape_sequence(mask[0])
      end

      def background
        Colours::Background.escape_sequence(mask[1])
      end
    end
  end
end
