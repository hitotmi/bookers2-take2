class BooksController < ApplicationController

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books =Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
   book = Book.find(params[:id])
     unless
       book.user_id == current_user
       redirect_to book_path(book.id)
     end
   @book =Book.find(params[:id])
  end

  def update
    @book =Book.find(params[:id])
    @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book)
  end
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
