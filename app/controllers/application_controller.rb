class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_guest

  def authenticate_guest
    if current_user
      puts "USER"

      if cookies[:guest_token]
        puts cookies[:guest_token]

        if current_user.carts.any?
          guest = Guest.find_by_jti(cookies[:guest_token])
          guest.destroy!
          @cart = current_user.carts.first
        else
          guest = Guest.find_by_jti(cookies[:guest_token])
          @cart = guest.carts.first
          @cart.update!(cartable_type: 'User', cartable_id: current_user.id)
          guest.destroy!
        end

        cookies.delete(:guest_token)
      else
        if current_user.carts.any?
          @cart = current_user.carts.create
        else
          current_user.carts.create!
        end
      end
    else
      puts "GUEST"

      if cookies[:guest_token]
        puts "HAS COOKIES"
        puts cookies[:guest_token]
        @guest = Guest.find_by_jti(cookies[:guest_token])
        puts "Guest with id #{@guest.id}"
      else
        puts "NO COOKIES"
        jti = SecureRandom.uuid
        @guest = Guest.create(jti: jti)
        cookies[:guest_token] = jti
        puts "Guest with id #{@guest.id}"
      end

      @cart = @guest.carts.first
    end

    # cookies.delete(:guest_token)
  end

end
