module Api
  module V1
    class RelationshipsController < ApplicationController
      # before_action :authenticate_user
      before_action :set_user

      def create
        following = @user.follow(@follow_user)
        if following.save
          render json: { user: @follow_user.as_json(include: [{ followings: { include: %i[followings followers], methods: :image_url } }, { followers: { include: %i[followings followers], methods: :image_url } }]), message: 'ユーザーをフォローしました', status: :created }
        else
          render json: { user: @follow_user.errors, message: 'ユーザーのフォローに失敗しました', status: :unprocessable_entity }
        end
      end

      def destroy
        following = @user.unfollow(@follow_user)
        if following.destroy
          render json: { user: @follow_user.as_json(include: [{ followings: { include: %i[followings followers], methods: :image_url } }, { followers: { include: %i[followings followers], methods: :image_url } }]), message: 'ユーザーのフォローを解除しました',
                         status: :accepted }
        else
          render json: { user: @follow_user.errors, message: 'ユーザーのフォロー解除に失敗しました', status: :unprocessable_entity }
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
        @follow_user = User.find(params[:follow_id])
      end
    end
  end
end
