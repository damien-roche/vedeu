#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_views_dsl.log'
    run_once!
    standalone!
  end

  Vedeu.interface :test1_interface do
    border do
      title 'Test 1'
    end
    geometry do
      x  4
      y  3
      xn 34
      yn 8
    end
  end

  Vedeu.interface :test2_interface do
    border do
      title 'Test 2'
    end
    geometry do
      x  36
      y  3
      xn 66
      yn 8
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }
  end

  Vedeu.render do
    view(:test1_interface) do
      lines do
        text 'view->lines->text'
      end
    end

    view(:test2_interface) do
      lines do
        left 'view->lines->left'
        # rest do not render
        centre 'view->lines->centre'
        center 'view->lines->center'
        right 'view->lines->right'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # EditorApp

DSLApp.start
