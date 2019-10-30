Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :users

  get "/users", to: "users#index", as: "user_index"

  get "/users/:id", to: "users#show", as: "display_user"

  post "/users", to: "users#create", as: "new_user"

  put "/users/:id", to: "users#update", as: "update_user"

  delete "/users/:id", to: "users#destroy", as: "delete_user"

  get "/users/new", to: "users#new", as: "get_user"

  get "/users/:id/edit", to: "users#edit", as: "edit_user"

  patch "/users/:id", to: "users#update", as: "patch_user"

end
