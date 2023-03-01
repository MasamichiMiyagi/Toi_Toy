Rails.application.routes.draw do

  # 管理者用サインアップ及びログイン
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    # registrations: "admin/registrations"はseeds.rb内にアカウントが内蔵されている為、そのままログイン画面に遷移で良い。
    sessions: "admin/sessions"
  }

  # 顧客用サインアップ及びログイン
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者側
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :games, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  # 顧客側(scope moduleを用いてURLにpublicが含まれないようにする)
  scope module: 'public' do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update, :destroy] do
      collection do
        get 'search'
      end
    end
    resources :games, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      collection do
        # 検索機能及び絞り込み機能
        get 'search'
        get 'player_search'
        get 'play_time_search'
      end
      resources :post_comments, only: [:create, :destroy]
    end
    #ゲストログイン（閲覧用）homes_controller内にメソッドを記載
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  end

end
