Swattr::Engine.routes.draw do
  devise_for :users,
             module: :devise,
             class_name: "Swattr::User",
             path: "",
             skip: [:omniauth_callbacks],
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               password: "password",
               confirmation: "verification",
               unlock: "unlock",
               registration: "register",
               sign_up: "signup"
             }

  resources :projects
  resources :issues
  resources :priorities
  resources :tags
  resources :tasks
  resources :resolutions
  resources :statuses
  resources :users

  resource :profile, except: [:new, :create]

  root to: "dashboards#show"
end
