Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'event_comments/create'
      get 'event_comments/destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      resources :top, only: [:index]
      resource :passwords, only: [:update]
      resources :relationships, param: 'follow_id', only: %i[create destroy]
      resources :posts, except: [:new]
      resources :events, only: %i[show create update destroy]
      resources :event_comments, only: %i[create destroy]
      resources :join_events, only: %i[create destroy]
      resources :likes, only: %i[create destroy]
      resources :comments, only: %i[create destroy]
      resources :users, except: [:edit] do
        get :current_user, action: :login_user, on: :collection
      end
      # ログイン・ログアウト処理
      resources :user_token, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
