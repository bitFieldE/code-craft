module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :authenticate_user
      before_action :set_user

      def create
        following = current_user.follow(@user)
        if following.save
          render json: { user: @user.as_json(include: [:followings, :followers, :tags, { posts: { include: [:tags], methods: %i[images_data] } }],
                                             methods: :image_url), message: 'ユーザーをフォローしました',
                         status: :created }
        else
          render json: { user: @user.errors, message: 'ユーザーのフォローに失敗しました', status: :unprocessable_entity }
        end
      end

      def destroy
        following = current_user.unfollow(@user)
        if following.destroy
          render json: { user: @user.as_json(include: [:followings, :followers, :tags, { posts: { include: [:tags], methods: %i[images_data] } }],
                                             methods: :image_url), message: 'ユーザーのフォローを解除しました',
                         status: :accepted }
        else
          render json: { user: @user.errors, message: 'ユーザーのフォロー解除に失敗しました', status: :unprocessable_entity }
        end
      end

      private

      def set_user
        @user = User.find(params[:follow_id])
      end
    end
  end
end
