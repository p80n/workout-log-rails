Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'workouts#index'

  resources :workouts
  resources :workout_sets
  resources :exercises
  resources :routines

end
