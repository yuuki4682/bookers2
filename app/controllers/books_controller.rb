class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
  end
  
  def index
    @books = Book.all
    
    @book = Book.new
  end
  
  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end
  
  def destroy
  end
  
  private
  def books_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
end
