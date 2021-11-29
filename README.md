# typo-detector
Most individuals end up repeatedly correcting some commonly occurring 
typos resulting from roll over in typing. One seems to more often type 
waht for what, realtion for relation, and inout for input. 

This PERL script would match such suspect typos and offer a replacement on 
confirmation. This is done by placing a ^ character below the 
word (with an extra line). On confirming with a response such as y, the 
replacement will be made. Responding with any other key will leave the 
word unchanged.

I have assumed that each input word would be a Linux command word.
The set of Linux commands are stored in the file “Dictionary.txt”.
You may add other words to increase the dictionary size.
Only those words (from “Dictionary.txt”) would be offered for replacement which will have the 
least edit distance w.r.t the input word.
