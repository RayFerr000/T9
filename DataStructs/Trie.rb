
class Trie
  attr_accessor :root
  
  def initialize
    @root = Node.new
  end
  
  #Put a Key, Value pair into the Trie
  def put(key, value)
    putKey(@root, key, value, 0)
  end  
  
  def putKey(node, key, value, nth_char)
    
    while nth_char <= key.length do
      if nth_char == key.length
        node.data = value
        break
      end
      
      char = key[nth_char]
      
      if node.next[char] == nil
        node.next[char] = Node.new
        node.children << char  
      end   

      node = node.next[char]
      nth_char+=1
    
    end
  end
  
  #Get a value associated with a particular key, if it exists
  def get(key)
    getKey(@root, key,  0)
  end

  def getKey(node, key, nth_char) 
    while nth_char <= key.length do
      
      return nil if node == nil
      
      return node if nth_char == key.length
      
      char = key[nth_char]
      node = node.next[char]
      nth_char+=1
    end
  end
  #Given some particular word, find words that have this word as a prefix up to some additional
  #number of character N
  def wordsWithPrefix(prefix, length)
    node = get(prefix)
    
    if node == nil      
      return nil
    else
      wordList = Hash.new
      if length !=0
        length+=prefix.length
      end
      collectKeys(node, length, prefix, prefix ,wordList)
      return wordList
    end
  end
  
  def collectKeys(node, n, word, prefix ,wordList)
    if n!=0
      return  if word.length > n 
    end
    
    if node.data != nil and node.data != prefix
      wordList[word]  =  word 
    end

    node.children.each do |char|
      collectKeys(node.next[char],n, word + char,prefix, wordList)
    end
  end

  #A Node class that represents a R-way Trie node
  class Node
    attr_accessor :data 
    attr_accessor :next
    attr_accessor :children
    
    def initialize
      @data = nil
      @next = Hash.new
      @children = Array.new
      ('a'..'z').each do |letter|
        @next[letter] = nil
      end
    
    end
  end
end




