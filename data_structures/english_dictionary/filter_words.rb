input_file = "english_dictionary.txt"
output_file = "three_letter_words.txt"

def filter_words(input_file, output_file, word_length)
  open_input_file = File.new(input_file, 'r')
  open_output_file = File.new(output_file, 'w')
  words = Array.new()

  open_input_file.each do |line|
    word = line.downcase.chomp
    words << word if word.length == word_length && word.match(/^[a-z]*$/)
  end

  words.each { |word| open_output_file << "#{word}\n" }
end

filter_words(input_file, output_file, 3)
