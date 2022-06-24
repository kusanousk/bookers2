Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root to: "homes#top"

  get "home/about" => "homes#about"
  resources :books, only: %i[index show edit create destroy update] do
    resource :favorites, only: %i[create destroy]
    resources :book_comments, only: %i[create destroy]
  end

  resources :users, only: %i[index show edit update] do
    member { get :follows, :followers }
  end

  resources :relationships, only: %i[create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
