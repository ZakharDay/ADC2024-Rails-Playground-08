class WelcomeController < ApplicationController
  
  def index
    name = 'TEST'
    @name = 'ADC'
  end

  def dice
    @dice = rand(0..9)
  end

end
