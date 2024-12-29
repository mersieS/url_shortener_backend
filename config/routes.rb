Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get 'urls', to: 'urls#index'
        get 'urls/:id', to: 'urls#show'
        post 'urls', to: 'urls#create'

        post 'users/sign_up' => 'users#sign_up'
        post 'users/sign_in' => 'users#sign_in'
        get  'users/token' => 'users#token'
      end
    end
  end
end
