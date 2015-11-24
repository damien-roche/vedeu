module Vedeu

  module Geometries

    # Provides the mechanism to align an interface/view vertically
    # within the available terminal space.
    #
    # @api private
    #
    class VerticalAlignment < Vedeu::Geometries::Alignment

      # @raise [Vedeu::Error::InvalidSyntax] When the value is not one
      #   of :bottom, :centre, :left, :middle, :right, :top.
      # @return [Symbol]
      def align
        return value if valid?

        fail Vedeu::Error::InvalidSyntax,
             'No vertical alignment value given. Valid values are :bottom, ' \
             ':middle, :none, :top.'.freeze
      end

    end # VerticalAlignment

  end # Geometries

end # Vedeu