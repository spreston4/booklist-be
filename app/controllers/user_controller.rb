class UserController < ApplicationController
  before_action :set_user, except: [:create]
  before_action :set_book, except: [:create, :show, :get_wishlist, :get_readlist]

  def show
  end

  def create
    puts("create called")
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

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.includes(wishlist: :books, readlist: :books).find_by(id: params["id"])
    render_not_found unless @user
  end

  def set_book
    @book = Book.find_by(id: params["book"]["id"])
    render_not_found unless @book
  end
end