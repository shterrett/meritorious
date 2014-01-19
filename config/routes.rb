Meritorious::Application.routes.draw do
  devise_for :teachers
  root to: 'high_voltage/pages#show', id: 'home'

  resources :classrooms, only: [] do
    resources :marks, only: [:create]
  end
end
