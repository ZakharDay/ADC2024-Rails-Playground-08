class Api::V1::WelcomeController < ApplicationController

  def index
    @pins = Pin.last(10)
    @comments = Comment.last(10)
  end

end
