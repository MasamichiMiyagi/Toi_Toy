Rails.application.routes.draw do

  # 管理者側
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :games, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  # 顧客側(scope moduleを用いてURLにpublicが含まれないようにする)
  scope module: 'public' do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :games, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

end
