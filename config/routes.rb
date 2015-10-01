Swattr::Engine.routes.draw do
  devise_for :users,
             module: :devise,
             class_name: "Swattr::User",
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               password: "password",
               confirmation: "verification",
               unlock: "unlock",
               registration: "register",
               sign_up: "signup"
             }

  resources :users

  resource :profile, except: [:new, :create]

  root to: "dashboards#show"
end
