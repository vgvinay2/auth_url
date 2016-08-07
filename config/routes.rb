Rails.application.routes.draw do
  
  # get 'urls/new'

  # get 'urls/create'
 resources :urls, only: [:new, :create]
  resources :short_visits
  resources :short_urls
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  resources :sessions,only: [:create]

  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "users#new"
  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :api, defaults: { format: :json } do
    namespace :v1 do 
       resources :sessions,only: [:create] do 
         collection do 
           delete :destroy, :as => "log_out"
         end 
       end 
       resources :users,only: [:create]
       resources :short_urls
       resources :short_visits,only: [:create]
    end
  end 
end
