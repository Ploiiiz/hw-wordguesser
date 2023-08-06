class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_reader :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    
    @Eng_letter = 'abcdefghijklmnopqrstuvwxyz'

    raise ArgumentError, 'Guess cannot be empty' if letter.nil? || letter.empty?
    letter = letter.downcase
    raise ArgumentError, 'Guess must be a English letter' unless @Eng_letter.include?(letter)
    

    if @word.include?(letter) && !@guesses.include?(letter)
      @guesses += letter
      true
    elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
      @wrong_guesses += letter
      true
    else
      false
    end
  end

  def word_with_guesses
    @word.chars.map { |char| @guesses.include?(char) ? char : '-' }.join('')
  end



  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word.chars.all? { |char| @guesses.include?(char) }
    :play
  end



  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
