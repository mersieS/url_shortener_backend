Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get 'urls', to: 'urls#index'

        post 'users/sign_up' => 'users#create'
        get 'users/get_token' => 'users#get_user_token'
      end
    end
  end
end
