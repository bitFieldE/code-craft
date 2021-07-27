module Api
  module V1
    class SearchController < ApplicationController
      def users
        users = if params[:keyword].empty?
                  []
                else
                  User.where('name Like ? OR description Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: users.as_json(include: %i[followings followers tags], methods: :image_url)
      end

      def posts
        posts = if params[:keyword].empty?
                  []
                else
                  Post.includes({ user: { image_attachment: :blob } }, :liked_users, :tags).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags])
      end

      def events
        events = if params[:keyword].empty?
                   []
                 else
                   Event.includes({ user: { image_attachment: :blob } }, :post, :tags, :join_users, { image_attachment: :blob }).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                 end
        render json: events.as_json(include: [{ user: { methods: :image_url } }, :post, :tags, :join_users], methods: :image_url)
      end

      def tags
        tags = if params[:keyword].empty?
                 []
               else
                 Tag.where('name Like ?', "%#{params[:keyword]}%")
               end
        render json: tags.as_json(include: %i[users posts events])
      end
    end
  end
end
