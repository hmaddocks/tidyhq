# frozen_string_literal: true

Rails.application.routes.draw do
  resources :urls do
    get '/:id', to: 'urls#show', id: /\d+/
    get '/:id', to: 'urls#show', id: /[a-zA-Z0-9]+/
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "urls#new"
end
