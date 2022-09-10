Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  root to: "homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # フォロー・フォロワー一覧の方はネストでいいのかな？
  resources :users, only: [:index,:show,:edit,:update] do
    get 'follows' => 'relationships#follows', as: 'follows'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # usersへネストさせないことに createとdestroyを含んだfollowとunfollow
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

  # 検索ボタンが押されると、Searchesコントローラのsearchアクションが実行される
  get 'search' => 'searches#search'

  # ゲストユーザーでのログインの実装
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end