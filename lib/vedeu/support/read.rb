module Vedeu

  # The basis of a fake input device.
  class Read

    # @param console []
    # @param data [String|NilClass]
    # @return [String]
    def self.from(console, data = nil)
      new(console, data).read
    end

    # @param console []
    # @param data [String|NilClass]
    # @return [Vedeu::Read]
    def initialize(console, data = nil)
      @console = console
      @data    = data
    end

    # Provides IO.console emulation of #getch.
    #
    # @return [String]
    def getch(string = nil)
      @data = string[0] unless string.nil?

      read
    end

    # Provides IO.console emulation of #gets.
    #
    # @return [String]
    def gets(string = nil)
      @data = string.chomp unless string.nil?

      read
    end

    # Provides IO.console emulation of #read_nonblock.
    #
    # @return [String]
    def read_nonblock(bytes = 1, string = nil)
      @data = string unless string.nil?

      read
    end

    # @return [String]
    def read
      if data
        data

      else
        ''

      end
    end

    private

    attr_reader :console, :data

  end # Read

end # Vedeu