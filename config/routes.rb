Bloccit::Application.routes.draw do

  root to: "welcome#index"

  get 'about' => "welcome#about"

  devise_for :users
  resources :users, only: [:index, :show, :update]
  resources :posts, only: [:index]

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
      get '/up-vote' => 'votes#up_vote', as: :up_vote
      get '/down-vote' => 'votes#down_vote', as: :down_vote
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
