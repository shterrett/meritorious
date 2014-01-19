Meritorious::Application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'home'

  resources :teachers, only: [] do
    resources :classrooms, only: [] do
      resources :marks, only: [:create]
    end
  end
end
