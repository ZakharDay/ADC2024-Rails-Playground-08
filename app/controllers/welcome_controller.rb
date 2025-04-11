class WelcomeController < ApplicationController
  
  def index
    name = 'TEST'
    @name = 'ADC'
  end

  def dice
    @dice = rand(0..9)
  end

  def search
    @items = PgSearch.multisearch(params['query'])
  end

end
