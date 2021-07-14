module Api
  module V1
    class EventCommentsController < ApplicationController
      def create
        event_comment = current_user.event_comments.new(event_comment_params)
        if event_comment.save
          render json: event_comment.as_json(include: [{ user: { methods: :image_url } }]), status: :created
        else
          render json: event_comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        event_comment = EventComment.find(params[:id])
        event_comment.destroy!
      end

      private

      def event_comment_params
        params.require(:event_comment).permit(:event_id, :user_id, :content)
      end
    end
  end
end
