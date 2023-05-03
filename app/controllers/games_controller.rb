class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample.to_s
    end
    @letters
  end

  def score
    @attempt = params[:attempt].split('')
    @letters = Hash.new(0)
    params[:letters].split('').each do |letter|
      @letters[letter] += 1
    end
    @letters = grid_attempt(@attempt, @letters)
    @score = final_score(@attempt, 9)
  end

  def grid_attempt(attempt, letters_hash)
    attempt.each do |attempt_letter|
      return false unless (letters_hash[attempt_letter]).positive?

      letters_hash[attempt_letter] -= 1
    end
    letters_hash
  end

  def final_score(word, time)
    calclulate_word_length_score(word) * calclulate_time_multiplyer(time)
  end

  def calclulate_word_length_score(word)
    word.length * 2
  end

  def calclulate_time_multiplyer(time)
    if time < 10 then 2
    elsif time >= 10 && time < 20 then  1.5
    elsif time >= 20 && time < 30 then  1
    elsif time >= 30 then 0 end
  end
end
