Bloccit::Application.routes.draw do
  root to: "welcome#index"
  get "welcome/index"
  get "welcome/about"
end
