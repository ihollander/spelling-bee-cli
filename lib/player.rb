class Player
  include DisplayHelper::InstanceMethods

  attr_reader :name
  attr_accessor :points, :status, :word_list

  def initialize(name)
    @name = name
    @points = 0
    @status = "Beginner"
    @word_list = []
  end

  def add_word(word)
    self.word_list << word
  end

  def add_points(points)
    self.points += points
  end

  # gets point total for user
  def display_total
    puts "Your points: #{self.points}"
  end

  # gets word list
  def display_word_list
    puts "Your words:"
    puts_to_columns(self.word_list.sort)
    puts ""
    puts "#{self.word_list.length} total words, worth #{self.points} total points."
  end

end
