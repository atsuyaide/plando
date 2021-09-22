Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]
  
  # チームは作成と削除が可能
  resources :teams, only: [:index, :show, :create, :destroy]
  
  resources :user_teams, only: [:create, :destroy]
end
