class WordlistBuilder
  include WordHelper::InstanceMethods

  def initialize
    puts "Building valid wordlist file..."
    build_dictionary_file
    puts "Building pangrams file..."
    build_pangram_file
  end

  def build_dictionary_file

    # open WORDLIST_FILE in write mode
    # NOTE: this clears the existing contents
    file_block = File.open(WORDLIST_FILE,"w")

    # loop through files in DICTIONARY_DIRECTORY
    Dir["#{DICTIONARY_DIRECTORY}/*.txt"].sort.each {|file|
      # read each line
      File.readlines(file).each{|word|
        # check if line is a valid word (has 4 or more letters)
        # if valid, puts to WORDLIST_FILE
        file_block.write(word.upcase) if valid_word?(word.gsub(/[\r\n]+/,""))
      }
    }

    file_block.close
  end


  def build_pangram_file

    # open PANGRAM_FILE in write mode
    # NOTE: this clears the existing contents
    pangram_file = File.open(PANGRAM_FILE,"w")

    # read through each line in WORDLIST_FILE
    File.readlines(WORDLIST_FILE).each{|word|
      # read to PANGRAM_FILE
      pangram_file.write(word.upcase) if pangram?(word.gsub(/[\r\n]+/,""))
    }

    pangram_file.close
  end

end
