require 'hamster'
require 'io/console'
require 'singleton'
require 'timeout'

require_relative 'vedeu/support/collection'
require_relative 'vedeu/support/clock'
require_relative 'vedeu/support/terminal'

require_relative 'vedeu/output/base'
require_relative 'vedeu/output/background'
require_relative 'vedeu/output/compositor'
require_relative 'vedeu/output/foreground'
require_relative 'vedeu/output/esc'
require_relative 'vedeu/output/mask'
require_relative 'vedeu/output/screen'
require_relative 'vedeu/output/translator'

require_relative 'vedeu/input/character/multibyte'
require_relative 'vedeu/input/character/standard'
require_relative 'vedeu/input/keyboard'
require_relative 'vedeu/input/parser'
require_relative 'vedeu/input/translator'

require_relative 'vedeu/interface/interface'

require_relative 'vedeu/process/commands'
require_relative 'vedeu/process/command'

require_relative 'vedeu/application'
require_relative 'vedeu/version'
