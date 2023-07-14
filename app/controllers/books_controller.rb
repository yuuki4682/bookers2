class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    
    @new_book = Book.new
  end
  
  def index
    @books = Book.all
    
    @new_book = Book.new
  end
  
  def create
    @new_book = Book.new(books_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@new_book.id)
    else
      @books = Book.all
      render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to '/books'
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  def books_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
end
