Rails.application.routes.draw do
  resources :sets, controller: 'source_sets', as: 'source_sets'

  root 'source_sets#index'
end
