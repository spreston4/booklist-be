class UsersController < ApplicationController
  def create
    if User.find_by(email: params["user"]["email"])
      render_duplicate_record
      return
    end
    
    @user = User.new(user_params)

    if @user.save
      Wishlist.create(user: @user)
      Readlist.create(user: @user)
      session[:user_id] = @user.id
      @status = :created
      @message = "User successfully created"
    else
      @status = 500
      @message = "Error creating User"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end