Rails.application.routes.draw do
  get 'signup' => 'users#new'
  resources :users
  resources :sessions, only: [:create]
  resources :employees
  resources :send_messages, only: [:create]
  resources :mobile_validates, only: [:create]
  resources :messages, only: [:create]
  resources :key_validates, only: [:create]
  resources :password_resets, only: [:update]
  resources :time_sets, only: [:update,:show]
  resources :corperations, only: [:show,:create]
  resources :departments, only: [:create, :show, :destroy, :index,:update]
  resources :employees, only: [:create, :show, :index, :update, :destroy]
  resources :get_macs, only: [:create]
  resources :statements, only: [:show]
  resources :calendars, only: [:create,:index,:update]
  post 'main_pages' => 'main_pages#show'
  get 'wifimacs/login' => 'wifimacs#new'
  get 'wifimacs/ping' => 'wifimacs#ping'
  get 'wifimacs/auth' => 'wifimacs#auth'
  get 'wifimacs/portal' => 'wifimacs#portal'
end
