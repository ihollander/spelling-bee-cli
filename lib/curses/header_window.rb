class HeaderWindow
  def initialize
    @window = Curses::Window.new(CursesScreen::HEADER_HEIGHT,
                                 CursesScreen::HEADER_WIDTH, 0, 0)
    @window.color_set(2)
  end

  def build_display
    @window << "Spelling Bee CLI".center(CursesScreen::HEADER_WIDTH)
    @window.refresh
  end
end
