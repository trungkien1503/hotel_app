# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  apipie

  scope module: 'api' do
    namespace :v1 do
      resources :hotels, only: %i[index show]
    end
  end

  root to: 'apipie/apipies#index'
end
