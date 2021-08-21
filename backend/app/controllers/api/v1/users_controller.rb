module Api
  module V1
    class UsersController < ApplicationController
      
      def show
        user = User.includes({ posts: [:user, :tags] },
                             { liked_posts: [:user, :tags] }, { events: [{ post: [:tags] }, :user, :join_users, :tags] },
                             { join_events: [{ event: [:user, { post: [:tags] }, :join_users, :tags] }] },
                             :followings, :followers, :tags).find(params[:id])
        render json: user.as_json(include: [{ posts: { include: [:tags] }},
                                            { events: { include: [{ post: { include: [:tags] } }, :user, :join_users, :tags]} },
                                            { liked_posts: { include: [:user, :tags, :liked_users] } },
                                            { join_events: { include: [{ event: { include: [:user, { post: { include: [:tags] } }, :join_users, :tags] } }] } },
                                            { followings: { include: %i[followings followers] } },
                                            { followers: { include: %i[followings followers] } }, :tags], methods: :tag_ranking)
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
