Rails.application.routes.draw do
  root to: "blogs#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :blogs
end
