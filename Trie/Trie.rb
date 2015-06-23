
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
      
      return node.data if nth_char == key.length
      
      char = key[nth_char]
      node = node.next[char]
      nth_char+=1
    end
  end
  #A Node class that represents a R-way Trie node
  class Node
    attr_accessor :data 
    attr_accessor :next
    
    def initialize
      @data = nil
      @next = Hash.new
      ('a'..'z').each do |letter|
        @next[letter] = nil
      end
    
    end
  end

end



