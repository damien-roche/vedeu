require 'vedeu/support/input'
require 'vedeu/support/terminal'

module Vedeu
  ModeSwitch = Class.new(StandardError)

  class Application
    # :nocov:
    def self.start(options = {})
      new(options).start
    end

    def initialize(options = {})
      @options = options
    end

    def start
      Terminal.open(mode) do
        Terminal.set_cursor_mode

        Vedeu.events.trigger(:_refresh_)

        runner { main_sequence }
      end
    end

    private

    attr_reader :options

    def runner
      if interactive?
        interactive { yield }

      else
        run_once    { yield }

      end
    end

    def main_sequence
      Input.capture

      Vedeu.events.trigger(:_refresh_)
    end

    def interactive?
      options.fetch(:interactive)
    end

    def interactive
      loop { yield }

    rescue ModeSwitch
      if Terminal.raw_mode?
        Application.start({ mode: :cooked })

      else
        Application.start({ mode: :raw })

      end
    end

    def run_once
      yield
    end

    def mode
      options.fetch(:mode)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        interactive: true,
        mode:        :raw
      }
    end
    # :nocov:
  end
end
