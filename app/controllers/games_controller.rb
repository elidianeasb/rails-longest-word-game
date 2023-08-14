# require "rest-client"
require "open-uri"

class GamesController < ApplicationController

  def index
  end

  def new
    @letters = [*('A'..'Z')].sample(10)
    @start_time = Time.now()
  end

  def score
    @letters = params[:letters]
    @start_time = params[:start_time]
    @word = params[:word]

    if (session[:player_score]).nil?
      session[:player_score] = 0
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = JSON.parse(URI.open(url).read)

    if response["found"] && @word.chars.all? {|char| @letters.include?(char.upcase)}
      session[:player_score] += @word.length
      @message = "Well Done!"
      @total_score = session[:player_score]
    else
      @message = "Sorry, word not valid"
    end
    @end_time = (Time.now() - @start_time.to_time).floor()
  end
end
