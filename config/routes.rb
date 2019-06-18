# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :stations, only: :index
      get :daily_indicators, to: 'stations#daily_indicators'
    end
  end
end
