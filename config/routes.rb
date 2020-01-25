Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1, constraints: { format: 'json' } do
      post 'logistic_meshes', to: 'logistic_meshes#create'
      get 'logistic_meshes/search', to: 'logistic_meshes#search'
    end
  end
end
