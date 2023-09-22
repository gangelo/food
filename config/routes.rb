# frozen_string_literal: true

Rails.application.routes.draw do
  resources :stores
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  # Define routes for the Api::ZipCodesController
  namespace :api, defaults: { format: 'json' } do
    get 'zip_codes/zip_code_data/:zip_code', to: 'zip_codes#zip_code_data', as: :zip_code_data
  end

  devise_for :users
end
