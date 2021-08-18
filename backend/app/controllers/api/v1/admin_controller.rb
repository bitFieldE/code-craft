module Api
  module V1
    class AdminController < ApplicationController
      # before_action :authenticate_user

      def users
        users = if params[:keyword].nil?
                  User.includes({ image_attachment: :blob }, :followings, :followers, :tags).all
                else
                  User.includes({ image_attachment: :blob }, :followings, :followers, :tags).where('name Like ? OR description Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: users.as_json(include: %i[followings followers tags], methods: :image_url)
      end

      def posts
        posts = if params[:keyword].nil?
                  Post.includes({ images_attachments: :blob }, { user: { image_attachment: :blob } }, :liked_users, :tags).all
                else
                  Post.includes({ images_attachments: :blob }, { user: { image_attachment: :blob } }, :liked_users, :tags).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                end
        render json: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags])
      end

      def events
        events = if params[:keyword].nil?
                   Event.includes({ image_attachment: :blob }, { user: { image_attachment: :blob } }, :post, :tags, :join_users).all
                 else
                   Event.includes({ image_attachment: :blob }, { user: { image_attachment: :blob } }, :post, :tags, :join_users).where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                 end
        render json: events.as_json(include: [{ user: { methods: :image_url } }, :post, :tags, :join_users], methods: :image_url)
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
                     Comment.includes({ user: { image_attachment: :blob } }).all
                   else
                     Comment.includes({ user: { image_attachment: :blob } }).where('content Like ?', "%#{params[:keyword]}%")
                   end
        render json: comments.as_json(include: [{ user: { methods: :image_url } }])
      end

      def event_comments
        event_comments = if params[:keyword].nil?
                           EventComment.includes({ user: { image_attachment: :blob } }).all
                         else
                           EventComment.includes({ user: { image_attachment: :blob } }).where('content Like ?', "%#{params[:keyword]}%")
                         end
        render json: event_comments.as_json(include: [{ user: { methods: :image_url } }])
      end
    end
  end
end
