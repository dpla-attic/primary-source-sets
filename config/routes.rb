Rails.application.routes.draw do
  devise_for :admins
  resources :sets, controller: 'source_sets', as: 'source_sets' do
    resources :sources, shallow: :true
    resources :guides, shallow: :true
  end
  resources :authors
  resources :images
  resources :documents
  resources :audios
  resources :videos
  resources :video_notifications, only: [:create]
  resources :audio_notifications, only: [:create]
  resources :tags
  resources :vocabularies

  root 'source_sets#index'
end
