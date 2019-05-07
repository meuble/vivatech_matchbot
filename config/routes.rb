Rails.application.routes.draw do
  scope format: true, constraints: { format: 'json' } do
    namespace :api do 
      namespace :v1 do 
        resources :data, only: [:create]
      end
    end
  end
end
