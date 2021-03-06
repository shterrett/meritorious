Meritorious::Application.routes.draw do
  devise_for :teachers
  root to: 'high_voltage/pages#show', id: 'home'

  resources :classrooms, only: [:index, :show, :new, :create] do
    resources :meetings, only: [:index]
    resource :student_imports, only: [:create]
  end
  resources :meetings, only: [:show, :create] do
    resources :marks, only: [:create]
    resource :meeting_report_exports, only: [:create]
  end
end
