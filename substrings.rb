
def match_substrings(final_array) # This function is the last part of our main substrings function, matching the dictionary array with our final substrings array. Its parameter is the final substrings array. 
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"] # We have to define the dictionary inside the function, or it will give an undefined variable error.
  result_hash = {} # Create an empty hash called result_hash to store our hash data.

  dictionary.each do |dictionary_word| # Loop through each word in the dictionary, and set each word to a variable "dictionary_word"
    count = 0 # Set the count of the dictionary word to 0. We don't want to do this inside the loop below bc then the count will get reset everytime it loops on to the next word. We want the count to save for each dictionary word.

    final_array.each do |substring_word| # Loop through the final array, with each array item being a "substring word" variable.
        if substring_word == dictionary_word # If the substring word matches the dictionary word...
        count += 1 # increase its count by 1.
        result_hash[dictionary_word] = "#{count}" # We add the dictionary word and its count value into our result hash. This code also updates the hash value "count", in case there are more matches for the dictionary word.
      end

    end
  end

  return result_hash # We need to explicitly return the result_hash, otherwise our output doesn't give us the answer.
end

def make_substrings(string) # This function takes a word ('string' parameter) and generates all the possible substrings of that word, so from 1 letter "words" substrings up to the actual "string.length" string itself.
  
  substring_array = []  # We declare an empty array "substring_array" that will hold all our substrings.
  for x in 0...string.length # Recall that we can access substrings of a string with "string[x,y]", where x denotes where to start in the string, and y is how many places to move past x. Therefore, to get all the substrings of a string, we push every combination of x, starting at 0 and ending at string.length, and every value of y, starting at 1 and ending at string.length - x, into our empty substring array.
    for y in 1..string.length-x
      substring_array.push(string[x,y])
    end
  end

  return substring_array # we have to explicitly return again, or the function won't give us our new array of substrings.
end

def filter_words(string) # This function filters out our strings for all punctuation. Basically, we match every character in the string with an alphabet array, if it doesn't match, it's not saved in our new filtered_word string.
  
  alphabet_array = ("a".."z").to_a # We can set an alphabet array by creating an alphabet string, using double dot notation to ensure that "a" and "z" are included in the alphabet, then "to_a" to convert that alphabet string into an array.
  filtered_word = "" # Set a filtered word string to be empty initially.
  letters_array = string.chars # Break up our string into individual characters and set it equal to "letters_array"
  letters_array.each do |letter| # Loop through each letter in letters_array
    if alphabet_array.include?(letter) # If the letter is in the alphabet array...
      filtered_word += letter # Add it to our filtered word string.
    end
  end
  return filtered_word
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"] # We need to define the dictionary so that the parameter is defined.
def substrings (string, dictionary) # This is our main function, taking a "string" parameter that can be a single word, or a sentence of words, and also a "dictionary" parameter, which is already defined.
  
  final_array = [] # set an empty array equal to final array to put all the substrings into
  downcase_string = string.downcase # Since this assignment is case insensitive, we want to downcase everything bc it matches with our lowercase alphabet array.
  words_array = downcase_string.split(" ") # We split our "string" parameter that has been downcased, into indiviudal words and put it inside a "words_array"

  filtered_words_array = [] # set an empty filtered words array to add our filtered words inside

  words_array.each do |word1| # Loop through each word (word1) in the words array...
    filtered_words_array.push(filter_words(word1)) # and filter each word, then add it to our filtered words array.

  end

  filtered_words_array.each do |word2| # Loop through each word (word2) of our filtered words array. Note that we gave each word in this array a different variable, as to not confuse it with the previous "word" variable, but these variables are all temporary and reside only within the loop, so we can technically use the same variable for all the loops.

    final_array.push(make_substrings(word2)) # Make substrings out of each filtered word and add it into our final array.
  
  end

  final_array = final_array.flatten # The final array will have arrays inside arrays, which is hard to work with, so we call the ".flatten" method, which takes all the array components and puts it inside 1 giant array.

  match_substrings(final_array) # Match each dictionary word to each substring within the final array.

end

substrings("below", dictionary) => {"below"=>"1", "low"=>"1"}
substrings("Howdy partner, sit down! How's it going?", dictionary) => {"down"=>"1", "go"=>"1", "going"=>"1", "how"=>"2", "howdy"=>"1", "it"=>"2", "i"=>"3", "own"=>"1", "part"=>"1", "partner"=>"1", "sit"=>"1"}

  




  