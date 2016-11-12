Rails.application.routes.draw do
  get 'background_check/new'

  get 'applicants/new'
	root 'applicants#new'
	

  resources :applicants, only: [:create, :update, :show, :new]
  resources :funnels, only: [:index]
end
