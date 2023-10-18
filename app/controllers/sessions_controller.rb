class SessionsController < ApplicationController
  include CurrentUserConcern

  def create
   @user = User.find_by(email: params.dig(:user, :email))

    if @user && @user.authenticate(params.dig(:user, :password))
      session[:user_id] = @user.id
      @status = :created
      @logged_in = true
    else
      @status = :unauthorized
      @logged_in = false
    end
  end

  def logged_in
    @logged_in = !!@current_user
  end

  def logout
    reset_session
  end
end