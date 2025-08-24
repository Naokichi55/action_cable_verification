Rails.application.routes.draw do
  get "static_pages/top"
  devise_for :users
  # get "rackets/index"
  resources :rackets do

  # コメント機能のルーティングを設定
    resources :comments, only: %i[create edit destroy], shallow:true
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #プロフィール投稿機能のルーティングを設定
    resources :profiles, only: %i[create new show update edit ]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # TOPページへ遷移するように変更
  root "static_pages#top"
  # root "rackets#index"

  #ログイン後にtopページに遷移するように変更。
  # root to:"top#index"
end
