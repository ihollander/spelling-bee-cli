require_relative 'curses_screen.rb'
require_relative 'header_window.rb'
require_relative 'main_window.rb'

@screen = CursesScreen.new
@screen.build_display
