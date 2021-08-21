module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: %i[create destroy]

      def show
        tag = Tag.includes(:users, { posts: %i[user liked_users tags] },
                           { events: %i[user post tags join_users] }).find(params[:id])
        render json: tag.as_json(include: [:users, { posts: { include: %i[user liked_users tags] } },
                                           { events: { include: %i[user post tags join_users] } }])
      end

      # タグのフォロー
      def create
        @tag.user_tag_maps.create(user_id: @user.id)
        render json: @tag.as_json(include: %i[users posts events]), status: :created
      end

      # タグのアンフォロー
      def destroy
        user_tag_map = UserTagMap.find_by(user_id: @user.id, tag_id: @tag.id)
        if user_tag_map.destroy
          render json: @tag.as_json(include: %i[users posts events]), status: :ok
        else
          render json: user_tag_map.errors, status: :unprocessable_entity
        end
      end

      def delete_tag
        tag = Tag.find(params[:tag_id])

        if tag.destroy
          render json: { message: 'タグを削除しました', status: :ok }
        else
          render json: tag.errors, status: :unprocessable_entity
        end
      end

      private

      def set_tag
        @user = User.find(params[:user_id])
        @tag = Tag.find(params[:id])
      end
    end
  end
end
