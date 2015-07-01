require_relative 'Trie'

class Cache
  attr_accessor :possibleWords
  attr_accessor :input
  attr_accessor :actualWords
  attr_accessor :trie
  attr_accessor :predicted

  def initialize
    @possibleWords = nil
    @input = []
    @actualWords = {}
    @trie = Trie.new
    @predicted = {}
    #load @trie with every word in English language
    file = File.open("DataStructs/allWords")
    begin
      while (line = file.readline)
        @trie.put(line.chomp, line.chomp)
    end
    rescue EOFError
      file.close
    end
  end

  def clear
    @possibleWords = nil
    @input.clear
    @actualWords.clear
    @predicted.clear
  end
end



