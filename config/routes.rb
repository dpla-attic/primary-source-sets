Rails.application.routes.draw do

  # Devise-related routes that handle sessions and account confirmation...
  devise_for :admins,
             controllers: {confirmations: 'confirmations'},
             skip: [:registrations]
  as :admin do
    patch '/admins/confirmation' => 'confirmations#update',
          :via => :patch,
          :as => :update_user_confirmation
  end
  authenticate :admin do
    scope '/admins' do
      devise_scope :admin do
        resources :registrations,
                  only: [:index, :create, :new, :edit, :update, :destroy]
      end
    end
  end

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
  resources :posters, only: [:index, :show]

  match 'sequences/sort', controller: :sequences, action: :sort, via: :post

  root 'source_sets#index'
end
