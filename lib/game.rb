class Game
  attr_accessor :board, :player
  attr_reader :nice_messages

  def initialize(arguments={})
    #initialize a new Board
    puts "Initializing board..."
    @board = Board.new(arguments)
    @nice_messages = ["Good!", "Excellent!", "Groovy!", "Sa-weet!", "Amaze. Wow!", "You're so good at this!", "Keep going!", "That's a real word, no foolin.", "Survey says: YUP! You found one.", "👌"]
  end


  def display_welcome
    puts File.read('./text/bee.txt')
  end

  # displays game rules
  def display_rules
    puts File.read('./text/rules.txt')
  end

  # take a user input and use board to return result
  def check_word(word)
    if self.player.word_list.include?(word)
      puts "Already found that one!"
    elsif word.length < 4
      puts "That word is too short. Words must be 4 letters or longer."
    elsif word.chars.include?(self.board.inner_letter) == false
      puts "Missing center letter."
    elsif self.board.word_list.include?(word)
      #get points total for word
      points = self.board.get_word_value(word)
      self.player.add_points(points)
      #adds word to wordlist
      self.player.add_word(word)
      if self.board.pangram?(word)
        puts "🐝 PANGRAM FOUND 🐝"
        puts "The bees are pleased. #{points} added to your score."
      else
        puts "#{self.nice_messages.sample} #{points} point#{"s" if points > 1} added to your score."
      end
      self.player.display_total
    else
      puts "Not in word list :("
    end
  end

  # game is over when the user has found all the words
  # this can check points total agains board total... or user word list against board word list. points is faster.
  def over?
    self.player.points == self.board.total_points
  end

  # starts a new game
  def play
    display_welcome
    puts ""
    display_rules
    puts ""
    print "Enter your name: "
    player_name = STDIN.gets.strip
    self.player = Player.new(player_name) # get the user
    puts "Welcome #{self.player.name}!"
    puts ""

    #play until user has maximum points or user inputs exit (breaks until)
    until over?
      puts ""
      self.board.display_board # puts the board on each turn
      print "Enter word: "
      user_input = STDIN.gets.strip
      puts ""
      # TODO: implement using Thor
      case user_input
        when "-q" || "-quit" || "-exit"
          self.player.display_word_list
          self.player.display_total
          puts "Bye!"
          break
        when "-h" || "-help"
          display_rules
        when "-t" || "-total"
          self.player.display_total
        when "-w" || "--word-list"
          self.player.display_word_list
        when "-r" || "-rearrange"
          self.board.rearrange_board
        when "--c-b" || "--cheater-bee"
          self.board.display_word_list
        else #
          check_word(user_input.upcase)
      end
    end

  end

end
