Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    post "/api/register", to: "api/users#create", as: :user_registration
    post "/api/login", to: "api/users#login", as: :user_login
    post "/api/tasks", to: "api/tasks#create", as: :task_creation
    post "/api/tasks/:id/assign", to: "api/tasks#assign", as: :task_assignation
    post "/api/tasks/assigned", to: "api/task_assignments#index", as: :assigned_tasks
    post "/api/tasks/:id/complete", to: "api/tasks#complete", as: :task_completion
  end
end
