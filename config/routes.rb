Rails.application.routes.draw do
 
  resources :documents
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root                'statics_pages#home'
  get    'help'    => 'statics_pages#help'
  get    'about'   => 'statics_pages#about'
  get    'contact' => 'statics_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

end
