require 'curses'

class CursesScreen
  SCREEN_HEIGHT      = 24
  SCREEN_WIDTH       = 80
  HEADER_HEIGHT      = 1
  HEADER_WIDTH       = SCREEN_WIDTH
  MAIN_WINDOW_HEIGHT = SCREEN_HEIGHT - HEADER_HEIGHT
  MAIN_WINDOW_WIDTH  = SCREEN_WIDTH

  def initialize

    # noecho()
    # Disables characters typed by the user to be echoed by ::getch as they are typed.
    Curses.noecho
    # nl()
    # Enable the underlying display device to translate the return key into newline on input, and whether it translates newline into return and line-feed on output (in either case, the call ::addch(‘n’) does the equivalent of return and line feed on the virtual screen).
    # Initially, these translations do occur. If you disable them using ::nonl, curses will be able to make better use of the line-feed capability, resulting in faster cursor motion. Also, curses will then be able to detect the return key.
    Curses.nonl
    # keypad(bool)
    # Enables the keypad of the user’s terminal.
    # If enabled (bool is true), the user can press a function key (such as an arrow key) and wgetch returns a single value representing the function key, as in KEY_LEFT. If disabled (bool is false), curses does not treat function keys specially and the program has to interpret the escape sequences itself. If the keypad in the terminal can be turned on (made to transmit) and off (made to work locally), turning on this option causes the terminal keypad to be turned on when #getch is called.
    # The default value for keypad is false.
    Curses.stdscr.keypad(true)
    # raw()
    # Put the terminal into raw mode.
    # Raw mode is similar to ::cbreak mode, in that characters typed are immediately passed through to the user program.
    # The differences are that in raw mode, the interrupt, quit, suspend, and flow control characters are all passed through uninterpreted, instead of generating a signal. The behavior of the BREAK key depends on other bits in the tty driver that are not set by curses.
    Curses.raw
    # nodelay = bool
    # When in no-delay mode #getch is a non-blocking call. If no input is ready getch returns ERR.
    # When in delay mode (bool is false which is the default), #getch blocks until a key is pressed.
    Curses.stdscr.nodelay = 1
    # init_screen()
    # Initialize a standard screen
    Curses.init_screen
    # start_color()
    # Initializes the color attributes, for terminals that support it.
    # This must be called, in order to use color attributes. It is good practice to call it just after ::init_screen
    Curses.start_color
    # init_pair(pair, f, b)
    # Changes the definition of a color-pair.
    # It takes three arguments: the number of the color-pair to be changed pair, the foreground color number f, and the background color number b.
    # If the color-pair was previously initialized, the screen is refreshed and all occurrences of that color-pair are changed to the new definition.
    Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
    Curses.init_pair(2, Curses::COLOR_BLACK, Curses::COLOR_YELLOW)
    Curses.init_pair(3, Curses::COLOR_BLACK, Curses::COLOR_WHITE)
  end

  def build_display
    @header_window = HeaderWindow.new
    @header_window.build_display
    @main_window = MainWindow.new
    @main_window.scroll
    @main_window.echo_keys # capture user input
  end
end

# Ref for curses setup:
# http://blog.brandon-conway.com/blog/2013/12/31/using-ruby-curses/
