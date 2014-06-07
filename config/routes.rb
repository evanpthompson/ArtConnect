ArtConnect::Application.routes.draw do
  get "museums/index"
  resources :museums
end
