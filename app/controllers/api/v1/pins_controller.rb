class Api::V1::PinsController < ApplicationController

  def index
    @pins = Pin.all
    # render json: @pins
    # render json: @pins.as_json
  end

  def show
    @pin = Pin.find(params[:id])
  end

end
