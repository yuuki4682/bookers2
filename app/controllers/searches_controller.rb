class SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @range = params[:range]
    
    if params[:range] == "user"
      @users = User.search(params[:condition], params[:word])
    else
      @books = Book.search(params[:condition], params[:word])
    end
  end
  
end
