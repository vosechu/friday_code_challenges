require './lib/letter_press'

lp = LetterPress.new("k g d g i
                      e g v c y
                      o w g l b
                      s u i i l
                      a l v p o")

(2..8).to_a.each do |i|
  puts "******** #{i} letter words ********"
  puts lp.words(i)
end