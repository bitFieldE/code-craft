module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user

      def create
        following = @user.follow(@follow_user)
        if following.save
          render json: { user: @user.as_json(include: [{ followings: { include: %i[followings followers] } }, { followers: { include: %i[followings followers] } }]), message: 'ユーザーをフォローしました', status: :created }
        else
          render json: { user: @user.errors, message: 'ユーザーのフォローに失敗しました', status: :unprocessable_entity }
        end
      end

      def destroy
        following = @user.unfollow(@follow_user)
        if following.destroy
          render json: { user: @user.as_json(include: [{ followings: { include: %i[followings followers] } }, { followers: { include: %i[followings followers] } }]), message: 'ユーザーのフォローを解除しました',
                         status: :accepted }
        else
          render json: { user: @user.errors, message: 'ユーザーのフォロー解除に失敗しました', status: :unprocessable_entity }
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
