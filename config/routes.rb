Bloccit::Application.routes.draw do

  root to: "welcome#index"

  get 'about' => "welcome#about"

  
  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create]
    end
  end

  devise_for :users
  resources :users, only: [:update]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts, only: [:index]
    end
  end

end
