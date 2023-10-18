class ReadlistController < ApplicationController
    before_action :set_book, except: [:index]
    before_action :set_user
  
    def index
      @readlist_data = @user.readlist.books
    end
  
    def add
      return unless @user && @book
      if book_exists?(@book.id)
        render_error("Book already exists on readlist.")
      else
        @user.readlist.books << @book
        render_success("Book successfully added to readlist!")
      end
    end  
  
    def remove
      return unless @user && @book
      if book_exists?(@book.id)
        @user.readlist.books.delete(@book)
        render_success("Book removed from readlist.")
      else
        render_error("Book does not exist on readlist.")
      end
    end
  
    private
  
    def set_user
      @user = User.includes(readlist: :books).find_by(id: params[:id])
      render_not_found unless @user
    end
  
    def set_book
      @book = Book.find_by(id: params.dig(:book, :id))
      render_not_found unless @book
    end

    def book_exists?(id)
        @user.wishlist.books.exists?(id)
    end
  end