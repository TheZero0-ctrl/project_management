Rails.application.routes.draw do
  resources :tasks, except: :new do
    member do
      get :task_file, action: :show, controller: 'task_files'
    end
  end
  resources :projects do
    member do
      resources :tasks, only: :new
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
