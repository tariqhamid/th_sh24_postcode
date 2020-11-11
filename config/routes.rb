# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'postcode#new'

  # get 'postcode', to: 'postcode#new'
  get 'index', to: 'postcode#index'

  get 'show', to: 'postcode#show'
end
