module WordHelper
  module InstanceMethods

    # check if the word is a valid pangram (exactly 7 unique letters)
    def pangram?(word)
      word.chars.uniq.length == 7
    end

    # word is valid if it is 4 or more characters
    # TODO: add additional validation logic for wordlist building (upper case characters only, etc)
    def valid_word?(word)
      word.length >= 4
    end

  end
end
