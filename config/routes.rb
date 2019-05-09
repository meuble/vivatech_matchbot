Rails.application.routes.draw do
  scope format: true, constraints: { format: 'json' } do
    namespace :api do 
      namespace :v1 do 
        resources :data, only: [:create, :index]
      end
    end
  end
  root to: 'results#index'
end
