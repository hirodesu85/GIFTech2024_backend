Rails.application.routes.draw do
  namespace :api do
    resources :places, only: [] do
      collection do
        get 'suggest'
        post 'arrive'
      end
    end
  end
end