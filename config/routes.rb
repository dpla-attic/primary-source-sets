Rails.application.routes.draw do
  devise_for :admins
  resources :sets, controller: 'source_sets', as: 'source_sets' do
    resources :sources, only: [:new, :create, :edit, :update, :show, :destroy]
    resources :guides, only: [:new, :create, :edit, :update, :show, :destroy]
  end
  resources :authors

  root 'source_sets#index'
end
