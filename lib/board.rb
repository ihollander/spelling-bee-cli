class Board
  include WordHelper::InstanceMethods, DisplayHelper::InstanceMethods

  attr_reader :outer_letters, :inner_letter, :word_list, :all_letters, :total_points

  WORDLIST_FILE = './words/validwords.txt'
  PANGRAM_FILE = './words/validpangrams.txt'

  # can initialize with a pangram on initializing or generate one at random
  # TODO: check how many words can be made from the pangram letters (15+) so the game isn't too short or too long (100+); remove challenging pangrams from the pangram file
  def initialize(arguments = {})
    inner_letter = arguments.fetch(:inner_letter, "").upcase
    outer_letters = arguments.fetch(:outer_letters, "").upcase
    if pangram?(inner_letter + outer_letters)
      @all_letters = inner_letter + outer_letters
      @inner_letter = inner_letter
      @outer_letters = outer_letters
    else
      @all_letters = get_random_pangram.chars.uniq.join
      @inner_letter = @all_letters.chars.sample
      @outer_letters = @all_letters.gsub(@inner_letter,"")
    end
    load_word_list
    get_total_points
  end

  # returns a new random pangram
  # OPTIMIZE: instead of looping through pangram file, start at a random position in the array? how many lines in file?
  def get_random_pangram
    puts "Generating pangram..."
    File.readlines(PANGRAM_FILE).map{|word|
      word.gsub!(/[\r\n]+/,"")
    }.sample
  end

  # loads valid words to word_list instance variable
  def load_word_list
    @word_list = []
    puts "Loading word list..."
    File.readlines(WORDLIST_FILE).each{|word|
      word.gsub!(/[\r\n]+/,"")
      if valid_word?(word, @inner_letter, @outer_letters)
        @word_list << word
      end
    }
    @word_list.sort!
    puts "Word list loaded."
  end

  # valid input rules:
  ## must include middle letter
  ## must be four letters or longer (this is handled by WordlistBuilder)
  ## can only be made from letters in the inner_letter+outer_letters arguments
  def valid_word?(word, inner_letter, outer_letters)
    word.include?(inner_letter) && word.chars.uniq.all? {|l| @all_letters.chars.include?(l) }
  end

  # TODO: implement levels hash based on total points available
  # has a hash of levels (Beginner < 10, Intermediate < 20, etc)
  def levels
    # divide total points available in to X tiers
    # set up a hash
    # Beginner - 1
    # Good start - 2
    # Moving Up - 3
    # good - 4
    # Solid - 5
    # Nice - 6
    # Great - 7
    # Amazing - 8
    # Genius - 9
    # Queen Bee - 10
  end

  # gets available points total from @word_list
  def get_total_points
    @total_points = 0
    self.word_list.each {|word|
      @total_points += get_word_value(word)
    }
  end

  # 4 letter words are worth 1 point
  # Longer words are worth the number of letters in the word
  # Pangrams get a 7 point bonus
  def get_word_value(word)
    word_value = word.length == 4 ? 1 : word.length
    if pangram?(word)
      word_value += 7
    end
    word_value
  end

  # randomly reorders the outer letters
  def rearrange_board
    puts "Letters rearranged."
    @outer_letters = self.outer_letters.chars.shuffle.join
  end

  def display_board
    game_board = File.read('./text/honeycomb.txt')
    game_board.gsub!("X", self.inner_letter)
    self.outer_letters.chars.each_with_index do |letter, index|
      game_board.gsub!(index.to_s, letter)
    end
    # game_board = self.outer_letters.chars.insert(3, "[#{self.inner_letter}]".yellow).join(" | ")
    puts game_board
  end

  # cheater cheater
  def display_word_list
    puts "All valid words (you cheater!):"
    puts_to_columns(self.word_list)
    puts ""
    puts "#{self.word_list.length} total words, worth #{self.total_points} total points."
  end
end
