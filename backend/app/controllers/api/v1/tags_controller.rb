module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: %i[show create destroy]

      def show
        render json: {
          tag: @tag.as_json(include: %i[users posts events]),
          posts: @tag.posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags]),
          events: @tag.events.as_json(include: [{ user: { methods: :image_url } }, :tags, :join_users], methods: :image_url)
        }
      end

      # タグのフォロー
      def create
        @tag.user_tag_maps.create(user_id: current_user.id)
        render json: @tag.as_json(include: %i[users posts events]), status: :created
      end

      # タグのアンフォロー
      def destroy
        user_tag_map = UserTagMap.find_by(user_id: current_user.id, tag_id: @tag.id)

        render json: @tag.as_json(include: %i[users posts events]), status: :ok if user_tag_map.destroy
      end

      private

      def set_tag
        @tag = Tag.find(params[:id])
      end
    end
  end
end
