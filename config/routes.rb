Rails.application.routes.draw do
  devise_for :admins
  resources :sets, controller: 'source_sets', as: 'source_sets' do
    resources :sources, shallow: :true
    resources :guides, shallow: :true
  end
  resources :authors

  root 'source_sets#index'
end
