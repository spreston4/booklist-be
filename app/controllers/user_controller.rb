class UserController < ApplicationController
  before_action :set_user
  before_action :set_book, except: [:get_wishlist, :get_readlist]
  
  def get_wishlist
    wishlist_data = @user.wishlist.books
  
    render json: {
      books: wishlist_data
    }
  end

  def add_to_wishlist
    return unless @user && @book
    if @user.wishlist.books.exists?(@book.id)
      render_error("Book already exists on wishlist.")
    else
      @user.wishlist.books << @book
      render_success("Book successfully added to wishlist!")
    end
  end  
  
  def remove_from_wishlist
    return unless @user && @book
    if @user.wishlist.books.exists?(@book.id)
      @user.wishlist.books.delete(@book)
      render_success("Book removed from wishlist.")
    else
      render_error("Book does not exist on wishlist.")
    end
  end

  def get_readlist
    readlistlist_data = @user.readlist.books
  
    render json: {
      books: readlist_data
    }
  end

  def add_to_readlist
    return unless @user && @book
    if @user.readlist.books.exists?(@book.id)
      render_error("Book already exists on readlist.")
    else
      @user.readlist.books << @book
      render_success("Book successfully added to readlist!")
    end
  end 

  def remove_from_readlist
    return unless @user && @book
    if @user.readlist.books.exists?(@book.id)
      @user.readlist.books.delete(@book)
      render_success("Book removed from readlist.")
    else
      render_error("Book does not exist on readlist.")
    end
  end

  private

  def set_user
    @user = User.find_by(id: params["id"])
    render_not_found unless @user
  end

  def set_book
    @book = Book.find_by(id: params["book"]["id"])
    render_not_found unless @book
  end
end