module Api
  module V1
    class CommentsController < ApplicationController
      def create
        comment = current_user.comments.new(comment_params)
        if comment.save
          render json: comment.as_json(include: [{ user: { methods: :image_url } }]), status: :created
        else
          render json: comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        comment = Comment.find(params[:id])
        comment.destroy!
      end

      private

      def comment_params
        params.require(:comment).permit(:user_id, :post_id, :content)
      end
    end
  end
end
