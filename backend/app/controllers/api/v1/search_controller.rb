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
                  Post.where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags])
      end

      def events
        events = if params[:keyword].empty?
                   []
                 else
                   Event.where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                 end
        render json: events.as_json(include: [{ user: { methods: :image_url } }, :tags, :join_users], methods: :image_url)
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
