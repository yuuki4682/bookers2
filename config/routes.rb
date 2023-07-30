Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "about"
  resources :users, only: [:show, :edit, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follows', as: 'follows'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books, only: [:show, :index, :new, :create, :destroy, :update, :edit] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  get 'search' => 'searches#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
