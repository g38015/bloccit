Bloccit::Application.routes.draw do
  root to: "welcome#index"

  get 'about' => "welcome#about"

  resources :posts

end
