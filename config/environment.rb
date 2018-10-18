require 'pry'
require 'thor' # CLI options parser
require 'paint' # colorize CLI output

require './lib/mod/word_helper'
require './lib/mod/display_helper' # order is important for include/extend/inherit
Dir["./lib/*.rb"].each {|file|
  require file
}

DICTIONARY_DIRECTORY = './words/dictionaries/EOWL-v1.1.2/LF Delimited Format'
WORDLIST_FILE = './words/validwords.txt'
PANGRAM_FILE = './words/validpangrams.txt'
