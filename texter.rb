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
=begin
post '/' do
 

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
  erb :form

end
=end

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
end


def allActualWords
  
  @@possibleWords.each do |i|
    
    if @@trie.get(i) != nil 
      @@actualWords[i]  =  i
    end
  end
end