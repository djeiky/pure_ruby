alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
vowels = "аеёиоуыэюя"
hash = {}

vowels.each_char do |vowel|
  hash[vowel.to_sym] = alphabet.index(vowel) + 1
end

puts hash
