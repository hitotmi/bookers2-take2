class BooksController < ApplicationController
  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   @book.save
   redirect_to books_path
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
