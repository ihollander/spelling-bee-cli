class CLI < Thor

  desc "build", "Generates the wordlist files."
  def build
    WordlistBuilder.new
  end

  desc "new", "Start a new game."
  method_option :letters, :aliases => "-l", :desc => "Start with pre-defined letters."
  def new
    args = {}
    if options[:letters]
      binding.pry
      args[:inner_letter] = options[:letters][0]
      args[:outer_letters] = options[:letters][1..-1]
    end
    game = Game.new(args)
    game.play
  end

end
