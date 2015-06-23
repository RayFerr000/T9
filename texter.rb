require 'sinatra'
require 'json'
require_relative 'Trie/Trie'


@@trie = Trie.new
@@input = Array.new
@@possibleWords = nil
@@actualWords = Hash.new

=begin
file = File.open("Trie/allWords")
begin
  while (line = file.readline)
    @@trie.put(line.chomp, line.chomp)
end
rescue EOFError
  file.close
end
=end


get '/' do 
  erb :form  
end

post '/' do
  
=begin
  if params[:characters] == 'clear' or params[:characters] == 'space'
    @@input.clear
    @@possibleWords = nil
    @@actualWords.clear
    if params[:characters] == 'clear' 
      return {:clear => true}.to_json 
    else 
      return {:space => true}.to_json
    end
  
  else
    @@input << params[:characters]
    allPossiblePermutations
    allActualWords 
    puts @@actualWords 
    
    return {:words => @@actualWords, :count => @@input.size}.to_json

  end
  '''
  erb :form
=end
end


def allPossibleWords
  #position determines how many cocsecutive positions to to put a char
  position = 3**(@@input.size-1)
  wordBuilder = Array.new(3**@@input.size,'')
  
  @@input.each do |i|
    # swap keeps track of when to switch to the next char of the input
    swap = 0
    # char keeps track of the current char
    char = 0
    
    (0..((3**@@input.size)-1)).each do |j|
      
      if swap == position
        swap = 0
        char == 2 ? char = 0 : char +=1 
      end
      
      wordBuilder[j]+= i[char]
 
      #if i == @@input[@@input.size]
      
      swap+=1
      
    
    end

    position/=3
  
  end
  @@possibleWords = wordBuilder
end

def allPossiblePermutations
  
  if @@possibleWords == nil
    @@possibleWords = Array.new(@@input.last.length, '')
    position = 1
  else
    position = @@possibleWords.length
    @@possibleWords *= @@input.last.length
  end
  
  currentChar = 0
  swap = 0
  
  (0..@@possibleWords.length-1).each do |i|
    if swap == position
      swap = 0
      currentChar == @@input.last.length ? currentChar = 0 : currentChar+=1
    end 
    
    @@possibleWords[i] += @@input.last[currentChar]
    swap+=1
  end
  p @@possibleWords
end


def allActualWords
  
  @@possibleWords.each do |i|
    
    if @@trie.get(i) != nil 
      @@actualWords[i]  =  i
    end
  end
end