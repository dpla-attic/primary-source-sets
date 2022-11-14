Rails.application.routes.draw do

  resources :sets, controller: 'source_sets', as: 'source_sets', only: [:index, :show], defaults: { format: 'json'} do
    resources :sources, shallow: :true, only: [:index, :show], defaults: { format: 'json' }
    resources :guides, shallow: :true, only: [:index, :show], defaults: { format: 'json' }
  end

  root 'source_sets#index', defaults: { format: 'json' }
end
