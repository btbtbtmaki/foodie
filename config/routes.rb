Rails.application.routes.draw do

  devise_for :users, controllers: {confirmations: 'confirmations'}

  # for relationship table
  resources :users do
    member do
      get :following, :followers
    end
  end

  namespace :pages do
    resources :posts
  end

  resources :pages do
    post :findfriend, :on => :collection
    post :resetbutton, :on => :collection
  end

  resources :relationships, only: [:create, :destroy]

  root 'pages#welcome'
  get 'recommend' =>'pages#recommend'
  #get 'pages/welcome'
  get 'welcome' => 'pages#welcome'

  get 'pages/signup'

  #get 'pages/home'
  get 'home' => 'pages#home'

  get 'foodmap' => 'pages#foodmap'




  #get 'pages/profile'
  # get 'profile' => 'pages#profile'
  get '/user/:id' => 'pages#profile'

  #get 'pages/new'
  get 'new' => 'pages#new'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
