class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create

  def create
    sign_in "user", @user

    if @user.valid_password?(sign_in_params[:password])
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        jti: @user.jti
      }, status: :ok
    else
      render json: {
        messages: "Sign In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end

  end

  def destroy
    @user = User.find_by_jti(decrypt_payload[0]['jti'])

    if @user && @user.update_column(:jti, SecureRandom.uuid)
      render json: {
        messages: "Signed Out Successfully",
        is_success: true,
        data: {}
      }, status: :ok
    else
      render json: {
        messages: "Signed Out Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  private

    def sign_in_params
      params.require(:user).permit(:email, :password)
    end

    def load_user
      @user = User.find_for_database_authentication(email: sign_in_params[:email])

      if @user
        return @user
      else
        render json: {
          messages: "Sign In Failed - Unauthorized",
          is_success: false,
          data: {}
        }, status: :unauthorized
      end
    end

end