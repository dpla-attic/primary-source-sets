Rails.application.routes.draw do
  devise_for :admins
  resources :sets, controller: 'source_sets', as: 'source_sets' do
    resources :sources, shallow: :true do
      resources :images, shallow: :true
      resources :documents, shallow: :true
      resources :audios, shallow: :true
      resources :videos, shallow: :true
    end
    resources :guides, shallow: :true
    resources :images, shallow: true
  end
  resources :authors

  root 'source_sets#index'
end
