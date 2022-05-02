Rails.application.routes.draw do
  devise_for :users
  resources :books
  get '/', to: 'books#index'
end
