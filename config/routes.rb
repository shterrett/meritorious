Meritorious::Application.routes.draw do
  devise_for :teachers
  root to: 'high_voltage/pages#show', id: 'home'

  resources :meetings, only: [] do
    resources :marks, only: [:create]
  end
end
