# T9 Predective Texter

A simple web application that somewhat emulates the T9 texter from all those years ago. While there is no reason for anyone to ever use this; It was fun to emulate.

###Tech Used

  - Sinatra 
  - Bootstrap
  - Jquery

To solve this problem, I first take the users input (each number is mapped to either a string of 3 or 4 unique characters) in the form of keypad clicks. After each button click, I generate a list of all possible permutations of the users input up to that point. The algorithm to find all permutations takes approximately O(3<sup>n</sup>) time. I then look up each permutation in a Trie I created containing a subset of the English language. For the text prediction, I take each permutation and see if there is a node within the Trie that corresponds to this sequence of characters. If there is a correspinding node, I then perform a Depth-First search at that node to try and find all words that have the given permutation as a prefix and has a length of `prefix.length + n`.


###Heroku Deployment
[pure-beyond-2056.herokuapp.com]

### Todo's

- Building the Trie takes approximately 4 seconds. I would like to speed this up by breaking the task up into threads to build the Trie in parallel.
- Hovering over a word will display its definition.

[pure-beyond-2056.herokuapp.com]:https://pure-beyond-2056.herokuapp.com/
