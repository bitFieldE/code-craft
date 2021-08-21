module Api
  module V1
    class SearchController < ApplicationController
      def users
        users = if params[:keyword].empty?
                  []
                else
                  User.where('name Like ? OR description Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: users.as_json(include: %i[followings followers tags])
      end

      def posts
        posts = if params[:keyword].empty?
                  []
                else
                  Post.includes(:user, :liked_users, :tags).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: posts.as_json(include: %i[user liked_users tags])
      end

      def events
        events = if params[:keyword].empty?
                   []
                 else
                   Event.includes(:user, :post, :tags, :join_users).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                 end
        render json: events.as_json(include: %i[user post tags join_users])
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
