Meritorious::Application.routes.draw do
  resources :teachers, only: [] do
    resources :classrooms, only: [] do
      resources :marks, only: [:create]
    end
  end
end
