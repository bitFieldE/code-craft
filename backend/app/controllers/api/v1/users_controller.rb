module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, only: %i[update destroy]

      def login_user
        render json: current_user.as_json(include: [{ posts: { methods: :images_data } }, :tags, :followings, :followers], methods: [:image_url]),
               status: :ok
      end

      def show
        user = User.includes({ image_attachment: :blob },
                             { posts: [{ images_attachments: :blob }, { user: { image_attachment: :blob } }, :tags] },
                             { liked_posts: [:tags] }, { events: [{ post: [:tags] }, { user: { image_attachment: :blob } }, { join_users: { image_attachment: :blob } }, :tags] },
                             { join_events: [{ event: [{ user: { image_attachment: :blob } }, { join_users: { image_attachment: :blob } }, :tags] }] },
                             :followings, :followers, :tags).find(params[:id])
        render json: user.as_json(include: [{ posts: { include: [:tags], methods: :images_data } },
                                            { events: { include: [{ post: { include: [:tags] } }, { user: { methods: :image_url } }, { join_users: { methods: :image_url } }, :tags], methods: :image_url } },
                                            { liked_posts: { include: %i[tags liked_users] } },
                                            { join_events: { include: [{ event: { include: [{ user: { methods: :image_url } }, { join_users: { methods: :image_url } }, :tags], methods: :image_url } }] } },
                                            :followings, :followers, :tags], methods: %i[image_url tag_ranking])
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

        if user.update(user_params)
          render json: user.as_json(include: %i[posts tags followings followers], methods: [:image_url]), status: :ok
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
