class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]
  def index
    books = Book.all
    render json: {
      books: books
    }
  end

  def create
    existing = Book.find_by(title: params["book"]["title"])
    if existing && existing.author == params["book"]["author"]
      render json: {
        status: 409,
        message: "Book already exists"
      }
    end

    book = Book.new(book_params)

    if book.save
      render json: {
        status: :created,
        book: book
      }
    else
      render json: {
        status: 500,
        message: "Error creating book"
      }
    end
  end

  def show
    render json: { book: @book }
  end

  def update
    if @book.update(book_params)
      render json: {
        status: :updated,
        book: @book
      }
    else
      render json: {
        status: 500,
        message: "Error updating book"
      }
    end
  end

  def destroy
    if @book.destroy
      render json: {
        status: :destroyed,
      }
    else
      render json: {
        status: 500,
        message: "Error deleting book"
      }
    end
  end

  private

  def set_book
    @book = Book.find(params["book"]["id"])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description)
  end
end