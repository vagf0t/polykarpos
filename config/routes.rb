Rails.application.routes.draw do
  resources :file_uploads, only: [:index, :new, :create, :destroy, :update]
    root "file_uploads#index"

  get 'file_uploads/index'

  get 'file_uploads/new'

  get 'file_uploads/create'

  get 'file_uploads/destroy'

  get 'file_uploads/update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
