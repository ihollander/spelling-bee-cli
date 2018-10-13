require_relative 'spec_helper.rb'

describe Board do

  let!(:board) { Board.new }
  let!(:board2) { Board.new }
  let!(:board_with_letters) { Board.new(inner_letter: "T", outer_letters: "NODMAR") }

  describe "#initialize" do

    it "can initialize a board with no arguments" do
      expect(board).to be_a(Board)
    end

    it "initializes with a random pangram if no pangram is assigned on init" do
      expect(board).to_not eq(board2)
    end

    it "can initialize with a pangram" do
      expect(board_with_letters.all_letters.chars.sort.join).to eq("ADMNORT")
    end
  end

  describe "#load_word_list" do

    it "contains all valid words based on current pangram" do
      #check against known wordlist?
    end
    
  end

end
