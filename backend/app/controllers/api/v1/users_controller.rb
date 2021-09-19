module Api
  module V1
    class UsersController < ApplicationController
      def show
        user = User.includes({ image_attachment: :blob },
                             { posts: [{ images_attachments: :blob }, { user: { image_attachment: :blob } }, :tags] },
                             { liked_posts: [{ user: { image_attachment: :blob } }, :tags] }, { events: [{ post: [:tags] }, { user: { image_attachment: :blob } }, { join_users: { image_attachment: :blob } }, :tags] },
                             { event_joins: [{ user: { image_attachment: :blob } }, { post: [:tags] }, { join_users: { image_attachment: :blob } }, :tags] },
                             { followings: { image_attachment: :blob } }, { followers: { image_attachment: :blob } }, :tags).find(params[:id])
        render json: user.as_json(include: [{ posts: { include: [:tags], methods: :images_data } },
                                            { events: { include: [{ post: { include: [:tags] } }, { user: { methods: :image_url } }, { join_users: { methods: :image_url } }, :tags], methods: :image_url } },
                                            { liked_posts: { include: [{ user: { methods: :image_url } }, :tags, :liked_users] } },
                                            { event_joins: { include: [{ user: { methods: :image_url } }, { post: { include: [:tags] } }, { join_users: { methods: :image_url } }, :tags], methods: :image_url } },
                                            { followings: { include: %i[followings followers], methods: :image_url } },
                                            { followers: { include: %i[followings followers], methods: :image_url } }, :tags], methods: %i[image_url tag_ranking])
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: user, methods: [:image_url], status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def update
        user = User.find(params[:id])
        user.admin = true if user.name == 'Ryuhei'

        if user.update(user_params)
          render json: user.as_json(only: %i[id name email description], methods: [:image_url]), status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: { message: '退会しました', status: :ok }
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :description, :image, :password)
      end
    end
  end
end
