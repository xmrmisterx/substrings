# substrings
This README consists of all our thoughts as we progressed through this substrings assignment for The Odin Project. Copied at the end is our "substrings" ruby file right after we got the correct solution, with commented out code still intact...

Alright, so we want to create a method (is that the same as a function?) called substrings, with 2 parameters, a custom string and an array of strings, or "dictionary". We want to return a hash (how do we do that?) that gives the word and the number of times it was found, for each word in our string variable. In plain English, we want to take in a string input, with a dictionary input, then output how many times each word in the string appeared in the dictionary.

From our understanding, a dictionary should be a hash, but the example in the assignment kinda looks like just an array of words? Not even sure what a dictionary is in this instance. It says it's given to us, and an array of substrings, so I guess that answers that. 

In psuedocode, we have a word or sentence given to us, and an array of words that we need to find how many matches there are for each word in the word or sentence given within that array of words (dictionary). First, we need to take the word. If it's a sentence, break down the sentence into words (how would we do that?). Then loop through the dictionary for a string that matches our word, and keep a running count of how many times each word appears in the dictionary. If the dictionary has only part of our word, like the first half, it still counts. It seems maybe we want to use .reduce here since it keeps a running total. However, we are alot less confident in this than the caesar_cipher one, where we kinda knew better what the steps, at least conceptually, were.

Ok, so we're gonna start with the default dictionary array given. We have the substring function, with a string parameter and dictionary parameter. We've filled out the dictionary parameter, and let's use a single word for our string to start off with, say "below". Do we need to modify the string as we did in the caesar cipher project? Let's google how to break a string into an array. Ahh, yes, the split method, which we tried in caesar cipher and it didn't do what we wanted. Let's test out some string splits and see what we get for the results. Alright, besides not having a second parameter put in for our substring function, that worked perfectly. We tested "below" and "below there" and the splitted arrays gave us ["below] and ["below","there"], which is what we want. 

So, splitting our string variable will give us an array of each word in the string, which is a start. Now, what do we want to do with these words? I think we want to loop through them, find matches in the dictionary, and keep track of all the matches. In the assignment example, the string given was "below", which matched once each for "below" and also "low" in the dictionary. How are we going to match "low" and "below"? I think this is gonna be a big hurdle, finding the correct method to use. If we iterate through the dictionary array, and look for any matches to the string, that is better I think, bc that finds "low" and "below" in "below".

Using code very similar to the caesar_cipher, we iterate through our dictionary and find matches in it to the words in the given string. However, it only found "below" in "below", but not "low". "low" and "below" are registering as different words, so maybe "include" is the wrong method? Googling, we find that we need to limit our string match to not just each word of the string, but each subset of words, which is what I think this assignment is about, substrings. In one example, a 5 letter string was broken down into substrings of 3 letters each, then we run the iterate the dictionary through these strings. So, essentially we want to break down each word in our string into 2 and 3 letter substrings, then enumerate the dictionary through that. How are we gonna do that? Let's think about this conceptually. We have an array of words. Now, we take each of those words, and break them down into individual letters. Ok, can we define the word "word" first of all? What is a "word". A "word" in this instance is a string of 2 or more letters. Conceptually, if the word in the dictionary matches 2 or more letters in the string word, in the correct order, that is considered a match, so how do we code that? First, we aren't talking about words in the string anymore. After breaking down the string sentence into words, we have to break the words down into letters. Actually, looking at the dictionary again, the word "i" is in there, so a match of just 1 letter can be considered a word, at least according to this dictionary. Let's repeat this again since it's a heavy concept to grasp. We are looking at each word (which consists of 1 or more letters) in the dictionary, and finding a match for that word in our string, even if there are extraneous letters before and after it.

What we're gonna need, is a function, that converts a word into a subset of words. For example, let's use "below". We need to iterate through below, the number of times based on its ".length". The first time, each letter is a word, so we push into a new array. So, this means we probably split "below" into individual letters,and put them into an array. Ah, yes, we did this before in caesar_cipher with "string.chars" method. Then we add string.index(0) and string.index(1) and get "be", string.index(1) and string.index(2) and get "el", and "lo", and "ow", accordingly. So, in equation form, we first take index[x], starting at 0, and add nothing to it, push into new array, then index[x+1]. That's our single letter word code. Then we take index[x] plus index[x+1], and accumulate by one on the x's here as well. This becomes our 2 letter words. Then we take index[x] plus index[x+1] plus index[x+2] and add those up to create our 3 letter words. We stop this pattern when index[value] >= string.length + 1.

Wow, we coded the index + 1 iteration for 2 letter words, and it worked first try. That was kind of surprising. Usually we mess up somewhere in the code or our logic is bad. We managed to code the 1 letter and 2 letter words, so now let's extend that logic to 3 and 4 letter words, up to the word length. We just coded the 3 letter variation, so now we have to think. If looping function has alot of similar parts. What are the parts that are actually different, so we can create a more general function just based on the length of each word.

We'll need a new_index each time we want to add another letter, so maybe some kinda of function that just counts up new_index up to string.length - 1? So what is new_index? It's basically just a number that accumulates everytime we loop through, up to string.length-1. Let's go over what our function wants to do again. We first loop through the first letter... Wait a minute, currently we are looping through the word everytime, and taking either 1, 2, 3, 4, or 5 word chunks and adding it to a resulting array, but why not iterate through each letter, and add itself to all the combinations with it to the resulting array? I think we can just loop through each letter only once... Let's talk this out, so we loop through the letter "b" of our example "below", and get all the single letters, so "b...w", moving through our string by adding 1 to the index each time, and pushing all of those single letters into our resulting array, then we add "be" plus "el", up to "ow." The index value itself doesn't even have to be a variable, we made it a variable for the code to be easier to read and follow, but it's value is derived from our letter variable, so the next letter of the word would always be the index of the letter plus 1. What we do need a variable on is the number of chunks we want to break the word up into, which is quite simply the word.size? word.length? whats the difference anyway? So, in more technical terms, we want to take "letter" and add "index_of(letter) + x" a "y" amount of times, where "x" starts at 1 and goes up by 1 everytime, up to word.length-1, and "y" is word.length-1. Since "y" is actually the final value of "x", why not just remove "y", and just set a stop when "x" is word.length - 1.

Another thought, why start at the single letter strings, when we can start at the word itself, or max letter string. This gives us a clear max, where we don't have a problem telling the code to stop at a certain string size? So... we start at "letter + (array.index_of(letter) + (array.length -1))", we can set "array.length - 1" to be equal to some variable, maybe "highest index", then "letter + (array.index_of(letter) + (highest_index - 1). Hmmm... this is the same difference now that we are thinking about it, except the ascending order we already have the code for.

Or try this... we have an initial new array of strings, of all the letters, ["b","e","l","o","w"], then we continue if x >= string.length - 1, so x starts at 1 maybe, and we loop through each of new array and add that index position plus x, we definitely need a variable for index_value, and if it's >= string.length - 1 we stop.. Next array, we have ["be","el","lo", "ow"].. Hmm, this doesn't work. I think our original code is fine, we just need to factor it to account for the variable number of times we add. This in theory seems very simple, as it's just dependent upon how big our word is, but, what's the relationship, what's the equation between the 2?

We have alot of ideas, but these ideas aren't really bearing fruit, let's just try to refactor our code and make it more general for a word of size "x". Let's go through the code and find all the parts that can stay the same first of all. The thing that sticks out the most is that we will be pushing our new strings into the new array, and so "substring_array.push(new_string)" will be in each iteration of our word loop, except the first one, where we are simply pushing the single letters through. However, this can be refactored if we set letter to new_string, and then push new string into the substring_array. Alright, so that part is consistent throughout all the loops, what else? We're always gonna set new string equal to letter, so that's another thing... what's the conditional for when we stop here? More specifically, what is the condition that will lead to function to add anther string to just the letter "+ letters_array[new_index]"? Looking it over, I think the letter variable is kind of confusing, and maybe is hindering what we want to the code to do? What if instead of letter, we refer to the first one in the letters_array as letters_array[0]. So, we start with letters_array[0], push it into new array, then go to the next arrays 1, 2, 3... up to index <= word.length. So, we definetly need a variable for index. Then we move on to the next one and do "letters_array[0] + letters_array[1]". How do we code this, in the context of a variable amount of times we'll do this, and a variable amount of words being added? Can we define these variables? Let's use our "below" example word again. How do we generically tell the code to keep adding more letter arrays, up to index being a certain value? "If" current_index <= max_index (which is equal to word.length - 1). Ok, i think we are getting somewhere, but we need another function, this time one that will determine how many letters we add, with 1 parameter being our letter, and another parameter being the number of times we'll add to our letter. I think this parameter should relate to our max_index somehow.

Alright, we defined a function called add_letters that will add letters to a letter to form substrings, with parameters for the letter in question, and the string size we want. Let's say we want a string size of 5, like for "below", what would our code do? Take string_array.index_at(letter), add "(string_array.index_at(letter) + 1)" We can use a while statement here, the condition being index <= string_size. So, we add letter to string_array[index], then increment index. This does get how far we want to add the indexes to, but it doesn't code for how many letters we are adding to letter. If it's a 5 letter word, doesn't index go up to 4, as well as maybe a variable "number_of_letters". Why don't we make another loop for that accounts for number of letters, a very simple one that can add a variable number of letters depending on string size.

We wrote the new method, but having tons of problems compiling. It keeps giving errors when we paste into irb of terminal. Alright, we finally figured that we didn't define new_string as an empty string before the loop, which made it say no method or something, although we don't remember having to define an empty string first in our first method that worked. We got it to loop over the first letter and print it and all it's possible string combos, so "b""be""bel""belo" and "below", but we just realized it didn't repeat this process for the next letter e. We need to make sure each loops through every letter, and finally check and see if the results are what we are trying to get. Ok, it seems the "break" in the code ends the loop completely, we tried "next" and the same thing happened, not sure there's a way to end iteration early and go on to the next letter within the word, so instead, let's try looping through each letter, with the same code. Lol, we got an error. It doesn't seem like we can loop through the letters here. Hmmm.. we are stuck a bit here. How do we tell the function to stop at the index, but still continue looping through the rest of the letters? Wait a minute, we took out the if statement completely, expecting it to give us an error since the code shouldn't make sense without a stop condition, but it returned the same array as the function with the if statement. Alright, we need to figure out why removing the if statement doesn't change the resulting array, and also how to get this function to iterate through more than just the first letter. Hmmm.. I think we are using the wrong function. Remember in the actual ruby lessons, they talk about how each always returns the original array, we just googled and maybe we need to use "map"? Lol, we tried map and it gives us the same result? The hell? We just printed the index result and it sent went 1 to 5, without the if statement, so it seems to stop, when the array stops? Maybe we don't need an if statement? Let's review how we got all the letters iterated in our original code. Why don't we set the index on the outside of the loop, starting it at 0, run the loop, change the index on the outside to plus 1, run the loop again, until the index 1 less than array.length? We were tinkering and if we remove the inside index, it just adds the first letter to itself, and we get "b", "bb", "bbb", etc. which is obv not want we want, so the inner index needs to stay.

Ok, so we managed to get the inner loop to repeat, putting it inside a while statement. And was able to repeat it 5 times, however, it gave us 5x of the same result. Each iteration added to the next, giving us "belowbelowbelowbelowbelow". Consider being more specific with the inner loop. Maybe we don't need the 'letter' variable, and just use the index and increment the index outside of the array loop? Or a second index, or use count, since we need the first index inside the loop for it to loop the way we want it to loop. This doesn't work. Setting the index to something, then changing it within the same loop, leads to the same index value next loop. 

Let's try this code out in simple English, What are we trying to do? Take the first letter, send it to new array. Take second letter, send it to new array, and so on. Actually no, here's what we actually want. Take the first letter, and loop through it, adding itself, then that and the next letter, then that and the next letter. There needs to be 2 loops here... a loop through the letters array for each letter, but then a loop through each letter, yeah, I think that's the part we're missing and the part we haven't been able to grasp. We learned the loop within a loop in the etch-a-sketch project, but it still hasn't really been ingrained in our mind it seems. Lol, this just duplicated the loop 5 times. I don't think the function inside does what we think it does, that's the problem now.

Let's try this in simple English again lol. Take the first letter, or current letter, set it to new string, then push it into array (=> "b"), then take the current letter again, and the next letter to it, set it to new string, and push it into array (=> "be"), then take the current letter, add the 2nd and 3rd letters to it, set it to new string, and push it into array... Basically, if there's only 1 letter, we push just the current letter. If there are 2 letters, we push "letter + (letter+1). If there are 3 letters, we push "letter + (letter+1) + (letter+2)". what is the mathematical equation for this? It's letter += letter + 1. No, that's not it. What if we think of the letter as index, does that help conceptually? So, if array has 1 item, index is 0. If array has 2 items, index is 1. This is a simple index = array - 1 relationship. What we need to know is the math equation for adding the indices. If array is 1, it's array[0], if array is 2, it's array[0]+ array[1]. Ok, let's stop here, we want to go step by step. Break a complex problem down into something simpler. How can we relate the array size of 2 so the array components we are adding. Wait a minute, it is x + (x*y). We thought math was useless but here we are. Googling math equations. In theory isn't this a very simple math problem? X + x + 1, but we don't understand how to expand this out. Let's print out the answers... x + 0, x + 1, x + (x+1) + (x+2), x + (x+1) + (x+2) + (x+3), x + (x+1) + (x+2) + (x+3) + (x+4). If we factor the last 3, it's 3x + 3, 4x + 6, and 5x + 10, is that helpful at all? Godamit, let's look at some sample solutions. Maybe we're barking down the wrong tree.

Looking at the solutions showed some interesting stuff. The answer to our problem seemed to lie in a loop within a loop, which we kinda guessed but couldn't implement. This particular solution didn't loop through the array with an each, rather it used a for loop, I guess like the for loop we used in etch-a-sketch, which was in javascript however. Also, ".." was used to represent a range, which honestly we had seen before, but never really used, such as in "0..string.length", which tells the loop how far to go, based on the size of the string, which was one of the things we were struggling with. We also notice that we need to use p or puts more to debug, at the important steps, to see why our code isn't working.

One of the things that we learned about, and apparently quickly forgot, is that we can get access to substrings with the string[x,y] notation. That is, string[0,1] returns the first string item, and string[0,4] returns the whole string, if it's 5 items long. Note that the range is in brackets. More significantly, string[0,2] would return a substring of "bel" from the "below" string, and that's exactly what we wanted to do sometimes and didn't realize we had the tools to do it. I think we made a mistake here racking our brain trying to come up with a solution, when our current toolbox is admittedly very small. We shoulda went for help much sooner, and looked at the solutions much sooner to stop wasting so much time. The readings and lecture on "problem solving" made it seem like we can just code anything by talking it out, but we don't know what we don't know, and we need to keep that in mind until we gain more experience and knowledge.

Ok, let's go through the code we found that does what we were trying to do, and explain it to ourself so we fully understand this. First off, what is the range we're looking for, in terms of the substrings notation... string(0,1)=> "b", string(0,2)=> "be", string (0,3)=> "bel", etc. So, we want to start with 0 for the first value, and get that up to 4 for the second value, or up to string.length - 1, thus "for i in 0...string.length
for g in 1..string.length-i". The i variable is the loop that goes through the first value, which ranges from 0 to 4. The g variable is for the second value, and it's being looped within the i loop, meaning at the value 0 (i=0), g=1, and we loop g 1 up to string.length - 1 times, giving us (0,1)(0,2).. up to (0,4). Note that the double dot notation means it's inclusive to both the bottom and top range. There is also a triple dot notation, which includes the bottom part of range, but excludes the top part of range. Once again, we did use this loop within a loop concept to make our grids in the etch-a-sketch project, but using a new language kinda threw us off, and we kinda forgot how to do it as well.

Alright, so we finally figured out how to create all our substrings, now what? First, we need to test this with multiple words (basically removing the spaces) and with punctuation, as in the example sentence. Let's try it. Wow, that "howdy..." sentence give us so many iterations, and the punctuation definitely was not accounted for. Let's go back to the earlier stages, before we got bogged down how to create all the substrings, and see how we wanted to break down a sentence. We can break down a string into an array of strings. This helps with the space problem in sentences, but still doesn't remove the punctuation, so we might need to google that. However, once we break down a sentence into its individual words strings, within an array, we simply iterate through each item in the word array and perform the double loop function right? Let's test this, and then figure out how to remove punctuation from our strings. So we do the function for "below there" and we get all the substrings in an array fine, but it's gone into 2 different arrays, instead of the same array. We need to debug this, but first, let's use a 3 letter sentence and see what happens. Yep, using a 3 word sentence gets us 3 different arrays. So, the options are to check with the dictionary after each array (seems faily simple to do), or combine the 3 arrays somehow into 1 array, before checking the dictionary. Let's rewind a bit. What do we want to do if the dictionary matches? We pull that value, and the number of times it matches, so I think ideally we want it all in 1 big array before checking?

It looks like when the loop goes on to the next word, the substring array is being cleared out... Reviewing the code, the substring_array is within the make_substring function, which takes each 'word' as a parameter, so when the next word comes in, the function is rerun and there is nothing in the substring_array. How do we make the substring array keep taking all the substrings? Let's try putting it outside the function? Let's think this through with just words. We have a function, that takes in a word, which we iterate over and create smaller words out of, and push into a substring array. When we move on to the second word, this substring_array is erased, which is why we get an array for each word. Why don't we put another array, 'final array', that we add into before on the next word? Yes! that did the trick. At the end of each word loop, we set "final_array += make_substrings(word)". Here, "make_substrings(word)" is the substring_array after each word is converted into substrings. And we return the final array, with the substrings of each word, joined together. 

Alright, so we have a final array that has all the substrings, of multiple words, joined now. Let's move onto the punctuation problem. How do we remove the punctuation from these arrays? How did we do it in caesar_cipher? As I recall, we matched each character to an alphabet array, and if the character didn't match, it didn't get pushed into a new filtering array, so we can do that again. Alright, so our initial thought, is to have a function, called "filter_words(string)" that takes in each string from our string_array and filters it, then returns the word without any punctuation. We want to loop through each letter, so .chars it, then if they don't match our lowercase alphabet array, we don't add it in our returned array. Let's try to code this like caesar_cipher method, then look up the "filter" method to see if that's a better way to do it. We were googling how to set up an alphabet without typing out the whole thing, and we thought it was pretty simple. We used "alphabet_array = ["a".."z"]", which didn't do anything. We saw that the correct notation is " = ("a".."z).to_a", but we don't understand why it has to be a parantheses instead of brackets. I guess that denotes a string, but that doesn't seem very intuitive. Don't we normally set arrays by setting their values, with bracket notation. This method involves setting the array to a string 'a to z', then converting it to an array using ".to_a".

Ok, looks like we solved the punctuation problem, and also the uppercase and lowercase problem. Since the words in this assignment are case insensitive, we downcase the original sentence to make sure. So... we've broken down our original sentence into separate words, then make all the possible substrings out of each word, and put it all into a final array to check vs the dictionary. Now we need to check if the final array includes words from our dictionary, add up the number of times it matches, and output that in a hash of the word and number of times word matched. Man, I think we are feeling a little burnt out and can't get this last piece of logic to determine how many times the word appears. We can't seem to be able to test this, althought it seems very easy to, just increase a count and display final count along with word. Let's try this in plain english. What are we wanting. We have a sentence given, which we've broken down into words, and parts of words called substrings, into a final array containing alll the words and substrings. We have a dictionary, or a list of words. and we want to know how many times each dictionary word appears within the final substring array. E.g. "how" in the dictionary should show up 2 times if "howdy" is in the final substring array, in the substring "how" and in the full word "howdy." So this would mean we iterate through all the words in the dictionary, and see if strings in the substring array matches that word. Let's do a test function with the "how" and "howdy" words. The dictionary should just have "how", while the final array should have "how" and "howdy". Somehow we tested this and it goes back all the way to our initial problem, 'how" shows up in "how", but it doesn't show up in "howdy". Let's print the important values and see where the code is faltering.

I think currently our code is just checking to see if the word "how" is in the array with "how" or "howdy", and it is, so it returns how, and that loop is actually done. What do we actually want the code to do? We want to grab the first dictionary word "how", then we want to check it through each word of our final substring array. If it matches, we add 1 to the count. Outside of that function, we can set the count equal to whatever the count is, but maybe inside set the key of the hash? Actually, it was simpler than that. We just needed to make the if statement checking for the word to be inside of a loop through each word of the final substring array, bc the previous code stopped at "how" when the if condition was met. Putting a loop through the final substring array made it check the second item in the test array "howdy" and that registered and ticked the count to 2 and it updated in the hash that printed. I think we tried this earlier, but maybe some error and it didn't compile, but mostly we were getting a little overwhelmed at that point, a little burnt out, and didn't finish trying what we wanted to try, but yeah, this works. Let's put all the little methods together into the big function and test it out with the assignment examples now. 

We've run into a stumbling block when trying to get the code to run with the long sentence. Something about "no implicit conversion of range into array". We think it might be coming from our filter words code, so we test it, and it seems to be working. Let's compile the whole thing and see if we still get the error. Maybe we changed something along the way, or was it the sentence put in. Hmm.. we get the same error, but the filter words function is fine. Maybe it's this last part, where we loop through the words array again and make final array. Let's test our make_substrings function, since the other one seems to be working. That's odd, now we're getting a no implicit conversion fo nil into array) after we tried to add words into a new filtered words array. Let's debug this a little more. What is returning from our filter words function? Ok, so our filtered_word_array is only showing one word, it's not adding up bc it's resetting everytime the loop is run, we need to fix that. Ok, I think we finally figured it out. First off, we were trying to add things to our filtered_words_array with "filtered_words_array += x", which doesn't work, bc we normally only use that for empty strings. To add to an array, we need to employ "push", that is "filtered_words_array.push(x)". Secondly, we didn't implicitly return the filtered word from the "filter_words" function, so when we tried to p out the "filtered_words_array" it gave us weird rejections bc it was "nil". We hadn't actually connected the dots yet and created a new array for our filtered words, which is why we had this hangup while simply combining all our working functions into the main function.

Let's try to add the "make_substrings" part of our code and hope nothing breaks. Lol, we get the can't convert range into array error again, but we notice that we made the same mistake as in our other function when we tried to combine them, namely we put "final_array += x", when arrays can only be added via ".push", while strings can use the "+=" notation to add. Ok, we fixed the make_substrings function, but we still have one more, the match_substrings. We don't really need a dictionary parameter for this, as dictionary is already defined outside our main function. Let's call match_substrings at the end of our main function and get our hash values. Lol, it does say dictionary is undefined. I honestly don't understand this. We define it. Ok, let's try to move it before our function, that might be the problem. It doesn't make sense that we define a variable outside a function, but the function can't call it. Lol, it really is the case. Didn't work again. It's pretty annoying having to define everything in the function, as opposed to a global variable outside the functions like in javascript. Lol, somehow when we were copying and pasting we doubled all our functions. Jesus, the hell.

We decide to remove the last step and see what prints out for final array and see if thats correct. For the most part it seems correct, but there seems to be an array within an array. There is a big overall array, and within that, individual arrays comprising of each word broken down. We need to iterate through this array, so this kinda of array is not going to work. We need 1 big single array with all the possible substrings. Is it maybe the display of the terminal, or is it actually giving us an array within an array? Don't we fix this by using the ".flatten" method? Googling shows that "flatten" might do the trick. It also says flatten has a parameter, where we can tell it how much to flatten, which might be useful. The hell, that didn't do anything, do we need to save it to something bc it doesn't return the new array? Yes, apparently we had to set it equal to its flattened self. That array looked messy, thank god for flatten. I remember initially glossing over the "flatten" method looking at the example saying "that looks dumb, why would i ever need to do that." lol. Let's add the final step and hopefull no more errors. Ok, we get the same error we got before we went on this sort of tangent, which was is final_array defined. We fixed the code to get final_array correct up tot his point, but now it's in a separate function and we can't define it. Since match_substrings doesn't have a parameter, let's put the final_array into it as a parameter and see if that works?

The code finally matched the words and spat out the hash keys and values. Unfortunately, all the hash values were 87? Lol, what? We're gonna have to debug the count and all relevant hash value parameters to see why it's so far off. The highest hash value should just be a 2. We tried it again when we woke up and it was still 87, then we go to comment out some print code, and now it doesn't return any hash at all. Ugh. Let's try to print out all the relevant arrays and see where it's going wrong now, before we go to why the count is seemingly off. Hmmm, the filtered words array seems fine, but the final array is off. It seems we got this value yesterday, how did we fix it? We've traced it down to the make_substrings function, apparently not making the right subtrings. Let's print out it's result, the one we commented out "p substring_array" and see what the output is. That's weird, uncommenting that p gave us the result we wanted? That sounds wrong. Let's test this substring array by itself? Actually the substring array might be a mess but, what is actually in the final array, that's what's really important, let's see what's in that first. 

I think there's something wrong with the make_substrings function. The resulting "substring_array" seems to be duplicated, but I also think flattening this results gives us a correct final array. If the final array is correct, then we just need to see why the hash values are all 87. Ok, so we got back to where we were yesterday, and taking a closer look at the final_array reveals that there are duplicates in here, so how do we take out the duplicates. Those might be messing up our count. Apparently that's the "uniq" method. We add the uniq method to the end of the flatten method, we've seen methods called on top of each other before, so we'll see if this works. "Uniq" worked, which is good, but how the hash values are all 66. First off, let's remove this 'p substring_array' code and see if it messes things up again. Maybe we actually need to return this array or something? Wow, we were right. Removing the p substring_array from make_substrings function breaks it. We thought we were just debugging with that line, but I think the function doesn't return anything otherwise? Let's replace p with a return and see what happens. Ok, so return is fine, as we expected, and now it doesn't just look like some debug code we put in to comment out. That's pretty weird. 

Let's go through our match_substrings function again and debug the count. Not sure why everything is 66. Hmmm... maybe that really short code solution was actually correct? Maybe we didn't even need to do all this substring breaking? We just didn't run a double loop the first time and so didn't find "low" in "low" and "below". Let's try something like that now. Iterating through the simpler substring method made us think maybe our match_substring function is wrong. Maybe instead of saying an array includes something, we should instead be saying 1 word from the array matches 1 word from the dictionary array. Using that same logic in our original code, now all our hash values are 1, which I guess is good bc it's alot closer to 1 and 2 than 87 or 66 lol. Let's debug our count a bit and see if we can get it to work right. Oh, I think i get it now. We wnted duplicates in the final array... That's how we're gonna match the dictionary_word "how" with the substring "how" in "howdy" and "how" in "hows". If we remove duplicates. that'll never happen. Let's unrun the 'uniq" method and try this new code and see if anything changes. Wow, that works. So, instead of using includes, we used "==" and that was the functionality we were looking for. I think we saw "include?" in one of the solutions so we tried that, but equals to is what we needed in our code. This error also made us incorrectly think that it was the duplicates in our array that caused the really high hash values, but in actuality we needed the duplicates, that's what separates the hash values of 0,1, and more. When we removed the duplicates, the values could only be 0 or 1.

This was the hardest assignment so far I'd say, probably twice as hard as anything before. Maybe bc we really tried to solve everything on our own, even though, in the end we had to look up the solutions for how to make an array of substrings out of a string. The calculator was challenging as well, but alot more immediate feedback in theory and testing. The for loop within a for loop concept is something that still wasn't intuitive and we just couldn't figure it out on our own.

While we were finishing adding notes and comments to our ruby file, we noticed that we didn't fully understand the double for loops and we couldn't figure out by ourself. The original poster used and i variable for first loop, and g variable for second loop, with the g variable range from "1 to string.lenth - i". We initially saw the "i" as a "1" and thought nothing of it, but when we changed the variables to "x" and "y" to be more relatable, we got an error saying undefined "i" variable. In the context of bracket notation for a substring, the formula makes sense in hindsight, but is obviously not something very intuitive to us. Basically, we have our first i loop giving us [0,1][0,2][0,3][0,4][0,5] for an example word like "below", which results in "b" "be" "bel" etc. What we failed to notice the first time around was the limit for "y" is "string.length - x", which means as "x" gets bigger, "y" gets smaller. Recall that "x" is the starting point of the string, and "y" is how many places to go after "x". So the farther along x is in the word, the less places it can move before reaching the end of the word, thus "y" range is "1..string.length-x".

Below is our code with all the deleted comments right after we got the correct answer.

# def substrings (string)

#   dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  
#   string_array = string.split(" ")
#   p string_array

#   # string_string= string_array.join
#   # p string_string
  
#   # dictionary.each do |word, count|
#   #     if string_array.include?(word)
#   #     count =+1
#   #     # p word
#   #     # p count
#   #     end
  
#   #   end
  
#   end
# substrings("below")
# substrings("below there")

# def split_into_strings(string) # This is a smaller function to test with within the bigger substring function.
  
#   substring_array = []

#   # string_array = string.split(" ") # break down sentence into strings
#   # letters_array = string_array[].chars # break down string into letters
#   letters_array = string.chars # let's do this simple way first, we can use "below" for the string
#   letters_array.each do |letter|
#     new_string = letter # We don't really need to set letter to a different variable, but our code later on uses new_string, so this makes the code more consistent looking.
#     # substring_array.push(letter)
#     substring_array.push(new_string)
#   end

#   letters_array.each do |letter|  # Loop through each letter again...
    
#     new_index = letters_array.find_index(letter) + 1 # Get the index of next letter to add and set it to new_index variable
#     new_string = letter + letters_array[new_index] # Add the current letter to the next letter and call it new_string
#     substring_array.push(new_string) # Add the new string into our substring array

#     if new_index >= (letters_array.length - 1) # If the index of the next letter we use is greater than or equal to 1 less than the length of our letter array, we stop; basically this ends the loop when we get to the end of our word.
#       break # We use break instead of return here. I believe break ends just this loop, while return ends the whole function, so break is correct here.
#     end
#   end

#   letters_array.each do |letter|

#     new_index1 = letters_array.find_index(letter) + 1
#     new_index2 = letters_array.find_index(letter) + 2

#     new_string = letter + letters_array[new_index1] + letters_array[new_index2]
#     substring_array.push(new_string)

#     if new_index2 >= (letters_array.length - 1)
#       break
#     end
#   end

#   letters_array.each do |letter|

#     new_index1 = letters_array.find_index(letter) + 1
#     new_index2 = letters_array.find_index(letter) + 2
#     new_index3 = letters_array.find_index(letter) + 3

#     new_string = letter + letters_array[new_index1] + letters_array[new_index2] + letters_array[new_index3]
#     substring_array.push(new_string)

#     if new_index3 >= (letters_array.length - 1)
#       break
#     end
#   end

#   letters_array.each do |letter|

#     new_index1 = letters_array.find_index(letter) + 1
#     new_index2 = letters_array.find_index(letter) + 2
#     new_index3 = letters_array.find_index(letter) + 3
#     new_index4 = letters_array.find_index(letter) + 4

#     new_string = letter + letters_array[new_index1] + letters_array[new_index2] + letters_array[new_index3] + letters_array[new_index4]
#     substring_array.push(new_string)

#     if new_index4 >= (letters_array.length - 1)
#       break
#     end
#   end

#     p substring_array
# end

# split_into_strings("below")

# def add_letters (letter, string_size)
#   new_string = letter 
#   substring_array.push(new string)

#   while index <= max_index do
#     new_string = letter + string_array[index]
#     index ++
#   end
# end

# def do_something (string) # This will give us duplicates. Wait, will it? Let's try it out and see.
#   substring_array = []
#   letters_array = string.chars

#   letters_array.each do |letter|

#     current_index = letters_array.find_index(letter)
#     new_string = new_string + letters_array[current_index]
#     substring_array.push(new_string)
#     index = index + 1
#     max_index = letters_array.length - 1

#     if index <= max_index
#       break
#     end
#   end
# end

# add_something("below")

# def do_something (string)
#   substring_array = []
#   new_string = ""
#   count = 0

#   letters_array = string.chars
  
#   # while (count <= letters_array.length)
  
#     letters_array.each do |letter|
      
#       5.times do

#         index = letters_array.find_index(letter)
#         new_string += letters_array[index]
#         substring_array.push(new_string)
#         index += 1
#       end

#     end

#   # count += 1
#   # end

#   p letters_array
#   p substring_array

# end

# do_something("below")


# def substrings(string,dictionary)

# final_array = []

def match_substrings(final_array)
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  # dictionary = ["how", "this"]

  # final_array = ["how", "howdy"]
  result_hash = {}

  dictionary.each do |dictionary_word|
    count = 0
    # puts "dictionary word: #{dictionary_word} , count: #{count}"

    final_array.each do |substring_word|
      # if final_array.include?(word)
        if substring_word == dictionary_word
        # puts "'#{substring_word}' matches '#{dictionary_word}'"
        count += 1
        # puts "final_array count: #{count}"
        result_hash[dictionary_word] = "#{count}"
      end

    end
  end

  return result_hash
end

def make_substrings(string)
  
  # substring_array = final_array
  substring_array = []
  for i in 0...string.length
    for g in 1..string.length-i
      # p "g is currently #{g} and i is currently #{i}"
      substring_array.push(string[i,g])
      # puts checker
    end
  end

  # final_array = substring_array

  # p final_array
  # p substring_array
  return substring_array
end

def filter_words(string)
  
  alphabet_array = ("a".."z").to_a
  filtered_word = ""
  # filtered_words_array = []
  # p string
  letters_array = string.chars
  letters_array.each do |letter|
    if alphabet_array.include?(letter)
      filtered_word += letter
    end
  end
  # filtered_words_array.push(filtered_word)
  # puts "filtered_word: #{filtered_word}"
  # p filtered_words_array
  return filtered_word
end

# filter_words("&*c798a798t")

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
def substrings (string, dictionary)
  
  final_array = []
  downcase_string = string.downcase # Since this assignment is case insensitive, we want to downcase everything bc it matches with our lowercase alphabet array.
  words_array = downcase_string.split(" ")

  # p words_array
  filtered_words_array = []

  words_array.each do |word1|
    # p word1
    filtered_words_array.push(filter_words(word1))

  end

  # p filtered_words_array

  filtered_words_array.each do |word2|
    # array[string_array.find_index(word)]= []
    # p word2

    # final_array += make_substrings(word2)
    final_array.push(make_substrings(word2))
    # p make_substrings(word2)
  
  end

  final_array = final_array.flatten
  puts "final array is: #{final_array}"

  match_substrings(final_array)

end

substrings("Howdy partner, sit down! How's it going?", dictionary)

# dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
# def simple_substrings(string, dictionary)

#   string_array = string.split
#   p string_array
#   dictionary.each do |dictionary_word|
#     p dictionary_word
#     count = 0
#     string_array.each do |string_array_word|
#       if string_array.include?(dictionary_word)
#         puts "string_array includes #{dictionary_word}"
#         count += 1
#         puts "'#{dictionary_word}' count is: #{count} "
#       end
#     end
#   end

# end
# simple_substrings('below', dictionary)
# simple_substrings('below there', dictionary)
