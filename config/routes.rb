Bloccit::Application.routes.draw do

  root to: "welcome#index"

  get 'about' => "welcome#about"

  devise_for :users
  resources :users, only: [:update]

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end

  # API Routes
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :topics, only: [:index, :show]
      resources :posts, only: [:index, :show]
      resources :comments, only: [:index, :show]
      resources :users, only: [:index, :show]
    end
  end

end
