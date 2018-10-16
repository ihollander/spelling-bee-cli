require 'pry'
require 'optparse' # options parser
require 'paint' # colorize CLI output

require './lib/mod/word_helper'
require './lib/mod/display_helper' # order is important for include/extend/inherit
Dir["./lib/*.rb"].each {|file|
  require file
}
