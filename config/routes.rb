Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  scope '/api' do
    defaults format: :json do

      scope '/curriculums' do
        get '', to: 'api_curriculums#index'
        get '/:curriculum_id', to: 'api_curriculums#show'

        get '/:curriculum_id/learning_units',
          to: 'api_learning_units#learning_units_of_curriculum'

        get '/:curriculum_id/completed_learning_units',
          to: 'api_completed_learning_units#'\
              'curriculums_learning_units_completed_by_user'
      end

      scope '/learning_units' do
        get '/:learning_unit_id', to: 'api_learning_units#show'
        get '/:learning_unit_id/resources',
          to: 'api_resources#resources_of_learning_unit'

        put '/:learning_unit_id/completed_learning_unit',
          to: 'api_completed_learning_units#update'

          post '/:learning_unit_id/resources', to: 'api_resources#create'

        get '/:learning_unit_id/is_completed',
          to: 'api_learning_units#completed?'

        delete '/:learning_unit_id/completed_learning_unit',
          to: 'api_completed_learning_units#uncomplete_learning_unit'
      end

      scope '/resources' do
        get '/:resource_id', to: 'api_resources#show'
        get '/:resource_id/resource_comments', to: 'api_resource_comments#show'
        post '/:resource_id/resource_comments',
          to: 'api_resource_comments#create'
        get '/:resource_id/resource_evaluation',
          to: 'api_resource_evaluations#show'
        put '/:resource_id/resource_evaluation',
          to: 'api_resource_evaluations#update'
      end

      get '/current_session', to: 'api_session#index'
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
