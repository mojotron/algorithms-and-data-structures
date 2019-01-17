input_file = "english_dictionary.txt"
output_file = "tree_letter_words.txt"

def filter_words(input_file, output_file, word_length)
  open_input = File.new(input_file, 'r')
  open_output = File.new(output_file, 'w')
  temp_dictionary = Array.new()

  open_input.each do |line|
    word = line.downcase.chomp
    temp_dictionary << word if word.length == word_length && word.match(/^[a-z]*$/)
  end

  temp_dictionary.each do |word|
    open_output << "#{word}\n"
  end
end

filter_words(input_file, output_file, 3)
