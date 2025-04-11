class WelcomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :search
  
  def index
    name = 'TEST'
    @name = 'ADC'
  end

  def dice
    @dice = rand(0..9)
  end

  def search
    @items = PgSearch.multisearch(params['search'])
    puts @items.count
  end

end
