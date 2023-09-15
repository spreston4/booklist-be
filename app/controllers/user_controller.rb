class UserController < ApplicationController
  
  def get_wishlist
    user = User.find(params["id"])
    wishlist_data = user.wishlist.books
  
    render json: {
      books: wishlist_data
    }
  end

  def add_to_wishlist
    user = User.find(params["id"])
    book = Book.find(params["book"]["id"])

    return unless user && book
    if user.wishlist.books.exists?(book.id)
      render json: {status: "Book already exists on wishlist"}
    else
      user.wishlist.books << book
      render json: {status: "Success"}
    end
  end  
  
  def remove_from_wishlist
    user = User.find(params["id"])
    book = Book.find(params["book"]["id"])

    return unless user && book
    if user.wishlist.books.exists?(book.id)
      user.wishlist.books.delete(book)
      render json: {status: "Success"}
    else
      render json: {status: "Book does not exist on wishlist"}
    end
  end
end