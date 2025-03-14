class LikesController < ApplicationController
  before_action :authenticate_user!

  def toggle
    @likeable = Object.const_get(params[:type]).find(params[:id])
    likes = @likeable.likes.where(user_id: current_user.id)

    if likes && likes.count > 0
      likes.each do |like|
        like.destroy!
      end
    else
      current_user.likes.create!(likeable_type: params[:type], likeable_id: params[:id])
    end

    LikesController.renderer.instance_variable_set(
      :@env, {
        "HTTP_HOST"=>"localhost:3000", 
        "HTTPS"=>"off", 
        "REQUEST_METHOD"=>"GET", 
        "SCRIPT_NAME"=>"",   
        "warden" => warden
      }
    )
  end

end
