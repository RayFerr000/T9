require 'sinatra/base'
require 'json'
require_relative 'DataStructs/Cache'


class WebApp < Sinatra::Base

  configure do
    set :cache , Cache.new
  end

  get '/' do
    settings.cache.clear 
    erb :form  
  end

  post '/' do
   

    if params[:characters] == 'clear' or params[:characters] == 'space'
      settings.cache.clear
      if params[:characters] == 'clear' 
        return {:clear => true}.to_json 
      else 
        return {:space => true}.to_json
      end
    
    else
      settings.cache.input << params[:characters]
      settings.cache.predicted.clear
      settings.cache.actualWords.clear
      
      allPossiblePermutations
      actualAndPredictedWords(2)
      
      if settings.cache.predicted.size == 0 and settings.cache.actualWords.size == 0 and settings.cache.input.size >2
        #If both predicted and actualWords is empty, the current string might be a couple of characters away from completion. 
        #If a there is a node that corresponds to the current sequence of characters, perform a full DFS on it to see if
        #and words can come from this combination of characters.
         actualAndPredictedWords(0)
         if settings.cache.predicted.size == 0
          return {:alert => true}.to_json
        end
       end
      return {:words => settings.cache.actualWords, :predicted => settings.cache.predicted, :count => settings.cache.input.size}.to_json

    end
    erb :form

  end


  def allPossiblePermutations
    
    if settings.cache.possibleWords == nil
      settings.cache.possibleWords = Array.new(settings.cache.input.last.length, '')
      position = 1
    else
      position = settings.cache.possibleWords.length
      settings.cache.possibleWords *= settings.cache.input.last.length
    end
    
    currentChar = 0
    swap = 0
    
    (0..settings.cache.possibleWords.length-1).each do |i|
      if swap == position
        swap = 0
        currentChar == settings.cache.input.last.length ? currentChar = 0 : currentChar+=1
      end 
      
      settings.cache.possibleWords[i] += settings.cache.input.last[currentChar]
      swap+=1
    end
  end


  def actualAndPredictedWords(length)
    
    settings.cache.possibleWords.each do |i|
      
      node = settings.cache.trie.get(i)
      
      if node
        if node.data != nil 
          settings.cache.actualWords[i]  =  i
          if node.data.length > 2
            predict = settings.cache.trie.wordsWithPrefix(i,length)
            settings.cache.predicted.merge!(predict)
          end
        elsif i.length > 2
          predict = settings.cache.trie.wordsWithPrefix(i,length)
          settings.cache.predicted.merge!(predict)
        end
      end
    
    end
  end
end
WebApp.run!