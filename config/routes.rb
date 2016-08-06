Rails.application.routes.draw do
  
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
    end
  end 
end
