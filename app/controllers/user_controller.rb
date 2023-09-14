class UserController < ApplicationController
  include CurrentUserConcern

  def get_wishlist
    return unless @current_user
  
    render json: {
      books: @current_user.wishlist.books
    }
  end

  def add_to_wishlist
    return unless @current_user && book
    return if @current_user.wishlist.books.exists?(book.id)
    book = params["book"]
    @current_user.wishlist.books << book
  end    
end