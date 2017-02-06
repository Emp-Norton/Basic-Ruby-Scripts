
def keychange_to_offset(keyword)
  key_array=keyword.split("") 
  key_array.each_with_index {|v,i| 
    key_array[i] = ((v.ord-"a".ord)+1).to_i} #+1 necessary otherwise "a" doesn't offset
  return key_array
end 

def cipher(string, key)
  key_array=keychange_to_offset("#{key}") #nice. do this more often (modular code)
  result="" 
  words=string.split(" ")
  words.each {|word|
    current_word=""
    letters=word.split("") 
    letters.each_with_index{|v,i|
      v=(((v.ord+key_array[i%key.length])-"a".ord)%26) #spend time thinking about why edge-cases/bookends
      current_word+=(v+"a".ord).chr}
      result+=current_word+" "}
    puts result
end 

def clear(string, key)
  clear=""
  key_array=keychange_to_offset("#{key}")
  words=string.split(" ")
  words.each{|word|
  current_word=""
  letters=word.split("")
  letters.each_with_index{|v,i|
    decoded_char=((((v.ord-"a".ord)-key_array[i%key_array.length])%26)+"a".ord).chr 
    current_word+=decoded_char}
    clear+=current_word+" "}
    puts clear
end 

def blap(type)
if type=="encoding"
  puts "What would you like to cipher today?"
    response=gets.chomp
  puts "What keyword would you like to use?"
    getkey=gets.chomp
  cipher("#{response}" , "#{getkey}")
elsif type=="decoding"
  puts "Please input the coded text:"
  coded=gets.chomp
  puts "Please provide the keyword:"
  key=gets.chomp
  puts "The text decodes to:" 
  clear("#{coded}" , "#{key}")
end 
end 

puts "Welcome to the Viginere Cipher. Are you encoding or decoding today?"
type=gets.chomp
if (type=="encoding"||type=="decoding") 
  blap(type)
else 
  puts "Response not valid, please try again."
end 




