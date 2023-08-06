class SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @range = params[:range]
    
    if params[:range] == "user"
      @users = User.search(params[:condition], params[:word])
    elsif params[:rang] == "book"
      @books = Book.search(params[:condition], params[:word])
    else
      @tag = Book.where(tag: params[:word])
    end
  end
  
end
