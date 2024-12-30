Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get 'urls', to: 'urls#index'
        get 'urls/:id', to: 'urls#show'
        get 'urls/:id/statistics', to: 'urls#statistics'
        get 'urls/:id/clicks_per_day', to: 'urls#clicks_per_day'
        post 'urls', to: 'urls#create'

        post 'users/sign_up' => 'users#sign_up'
        post 'users/sign_in' => 'users#sign_in'
        get  'users/token' => 'users#token'
      end
    end
  end

  get '/:short_url', to: 'redirects#redirect', as: :short

  root "controller#action"
end
