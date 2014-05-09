Bloccit::Application.routes.draw do
  devise_for :users
  root to: "welcome#index"

  get 'about' => "welcome#about"

  resources :posts

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts, only: [:index]
    end
  end

end
