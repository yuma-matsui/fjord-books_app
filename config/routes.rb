Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users, only: [:index, :show]
  get '/', to: 'books#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
