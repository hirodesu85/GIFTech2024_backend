Rails.application.routes.draw do
  namespace :api do
    namespace :places do
      get 'suggest', to: 'places#suggest'
    end
  end
end
