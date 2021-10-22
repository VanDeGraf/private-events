Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :events, only: [:index, :show, :new, :create, :edit, :update]
  resources :users, only: [:show]
  get "events/:id/attend", to: "events#attend"
  root to: "events#index"
end
