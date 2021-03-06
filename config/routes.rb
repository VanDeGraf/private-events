Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :events
  resources :users, only: [:show]
  get "events/:id/attend", to: "events#attend"
  get "events/:id/leave", to: "events#leave"
  root to: "events#index"
end
