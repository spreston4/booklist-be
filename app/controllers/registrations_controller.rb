class RegistrationsController < ApplicationController
  def create
    if User.find_by(email: params["user"]["email"])
      render_duplicate_record
      return
    end
    
    user = User.new(user_params)

    if user.save
      Wishlist.create(user: user)
      session[:user_id] = user.id
      render json: {
        status: :created,
        user: user
      }
    else
      render json: { 
        status: 500,
        message: "Error creating account" 
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end