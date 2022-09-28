Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  
  #For API routes use get/to to redirect to the API controller
  scope '/api' do
    defaults format: :json do
      get '/curriculums', to: 'api_curriculums#index'
<<<<<<< HEAD
      get '/learning_units', to: 'api_learning_units#index'
=======
>>>>>>> 59b31b8 (feat: Change API  logic>api_curriculum controller)
    end
  end

  resources :resources, only: %i[show] do
    resources :resource_comments, only: %i[create]
    resources :resource_evaluations, only: %i[create]
  end

  resources :curriculums, only: [:show] do
    resources :learning_units, only: [:index]
  end

  resources :learning_units, only: [:show] do
    resources :resources, only: %i[create]
    resources :completed_learning_units, only: %i[create destroy]
  end

  root 'curriculums#show'
end