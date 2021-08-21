module Api
  module V1
    class AdminController < ApplicationController
      def users
        users = if params[:keyword].nil?
                  User.includes(:followings, :followers, :tags).all
                else
                  User.includes(:followings, :followers, :tags).where('name Like ? OR description Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: users.as_json(include: %i[followings followers tags])
      end

      def posts
        posts = if params[:keyword].nil?
                  Post.includes(:user, :liked_users, :tags).all
                else
                  Post.includes(:user, :liked_users, :tags).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: posts.as_json(include: %i[user liked_users tags])
      end

      def events
        events = if params[:keyword].nil?
                   Event.includes(:user, :post, :tags, :join_users).all
                 else
                   Event.includes(:user, :post, :tags, :join_users).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                 end
        render json: events.as_json(include: %i[user post tags join_users])
      end

      def tags
        tags = if params[:keyword].nil?
                 Tag.includes(:users, :posts, :events).all
               else
                 Tag.includes(:users, :posts, :events).where('name Like ?', "%#{params[:keyword]}%")
               end
        render json: tags.as_json(include: %i[users posts events])
      end

      def comments
        comments = if params[:keyword].nil?
                     Comment.includes(:user).all
                   else
                     Comment.includes(:user).where('content Like ?', "%#{params[:keyword]}%")
                   end
        render json: comments.as_json(include: [:user])
      end

      def event_comments
        event_comments = if params[:keyword].nil?
                           EventComment.includes(:user).all
                         else
                           EventComment.includes(:user).where('content Like ?', "%#{params[:keyword]}%")
                         end
        render json: event_comments.as_json(include: [:user])
      end
    end
  end
end
