module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: [:update, :destroy]

      def show; end

      def create
        post = Post.find(event_params[:post_id])
        event = Event.new(event_params)
        event.user = current_user
        event.post = post

        if event.save
          render json: { event: event.as_json(include: [{ post: { include: [:tags] } }, { user: { methods: :image_url } }, :join_users]), message: 'イベントを作成しました', status: :created }
        else
          render json: event.errors, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(event_params)
          render json: @event.as_json(include: [{ post: { include: [:tags] } }, { user: { methods: :image_url } }, :join_users]), status: :ok
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @event.destroy
          render json: { message: 'イベントを削除しました', status: :ok }
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      def event_params
        params.require(:event).permit(
          :user_id,
          :post_id,
          :image,
          :title,
          :content,
          :place,
          :participant_number,
          :scheduled_date,
          :start_time,
          :end_time
        )
      end
    end
  end
end
