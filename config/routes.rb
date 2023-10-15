# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'home#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :stores do
    collection do
      get 'add'
      post 'add_create'
      get 'search'
    end
  end

  scope path: 'user' do
    resources :stores, controller: 'user_stores', as: 'user_stores' do
      # post 'archive', on: :member
      # post 'unarchive', on: :member

      collection do
        get 'add'
        post 'add'
      end
    end
  end
  post 'user/stores/link', to: 'user_stores#link', as: :link_user_store

  # Define routes for the Api::ZipCodesController
  namespace :api, defaults: { format: 'json' } do
    get 'zip_codes/zip_code_data/:zip_code', to: 'zip_codes#zip_code_data', as: :zip_code_data
  end

  resources :items, except: %i[destroy] do
    post 'archive', on: :member
    post 'unarchive', on: :member
    get 'search', on: :collection
  end

  resources :shopping_lists

  scope path: 'user' do
    resources :shopping_lists, controller: 'user_shopping_lists', as: :user_shopping_lists do
      collection do
        get 'add'
        post 'add'
      end
    end
  end

  devise_for :users
end
