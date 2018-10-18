class MainWindow
  def initialize
    # new(height, width, top, left)
    # Construct a new Curses::Window with constraints of height lines, width columns, begin at top line, and begin left most column.
    # A new window using full screen is called as Curses::Window.new(0,0,0,0)
    @window = Curses::Window.new(CursesScreen::MAIN_WINDOW_HEIGHT, CursesScreen::MAIN_WINDOW_WIDTH, 1, 0)
    # scrollok(bool)
    # Controls what happens when the cursor of a window is moved off the edge of the window or scrolling region, either as a result of a newline action on the bottom line, or typing the last character of the last line.
    # If disabled, (bool is false), the cursor is left on the bottom line.
    # If enabled, (bool is true), the window is scrolled up one line (Note that to get the physical scrolling effect on the terminal, it is also necessary to call #idlok)
    @window.scrollok(true)
    # idlok(bool)
    # If bool is true curses considers using the hardware insert/delete line feature of terminals so equipped.
    # If bool is false, disables use of line insertion and deletion. This option should be enabled only if the application needs insert/delete line, for example, for a screen editor.
    # It is disabled by default because insert/delete line tends to be visually annoying when used in applications where it is not really needed. If insert/delete line cannot be used, curses redraws the changed portions of all lines.
    @window.idlok(true)
    # color_set(col)
    # Sets the current color of the given window to the foreground/background combination described by the Fixnum col.
    @window.color_set(1)
    # setpos(y, x)
    # A setter for the position of the cursor in the current window, using coordinates x and y
    @window.setpos(CursesScreen::MAIN_WINDOW_HEIGHT - 1, 0)
  end

  def addch_example
    @window.addch('T')
    @window.addch('h')
    @window.addch('i')
    @window.addch('s')
    @window.addch(' ')
    @window.addch('i')
    @window.addch('s')
    @window.addch(' ')
    @window.addch('p')
    @window.addch('a')
    @window.addch('i')
    @window.addch('n')
    @window.addch('f')
    @window.addch('u')
    @window.addch('l')
    @window.addch('!')
  end

  def addstr_example
    @window.addstr('Ahhh, that is better.')
  end

  def push_example
    @window << "Wow, that is even easier!"
  end

  def scroll
    @window.scroll
    @window.setpos(CursesScreen::MAIN_WINDOW_HEIGHT - 1, 0)
  end

  def echo_keys
    self.scroll
    @window << "Press a key to get the ordinal value. Press 'q' to quit."
    until (input = @window.getch) == 'q'
      self.scroll

      @window << "You pressed: #{input}."
      unless input.is_a?(Fixnum)
        @window << " That character has an ordinal value of: #{input.ord}"
      end

      @window.refresh
    end
  end
end
