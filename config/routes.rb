Swattr::Engine.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

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

  resources :projects, concerns: [:paginatable] do
    resources :issues, concerns: [:paginatable]
  end
  resources :priorities
  resources :tags
  resources :tasks
  resources :resolutions
  resources :statuses
  resources :users, concerns: [:paginatable]

  resource :profile, except: [:new, :create]
  resource :settings, only: [:show, :edit, :update]

  root to: "dashboards#show"
end
