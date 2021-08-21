module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_user, only: :create
      before_action :set_event, only: %i[show update destroy]

      def show
        render json: @event.as_json(include: [{ post: { include: [:tags] } }, :user, :join_users,
                                              { event_comments: { include: [:user] } }])
      end

      def create
        post = Post.find(event_params[:post_id])
        event = Event.new(event_params)
        event.user = @user
        event.post = post
        tag_list = []
        tags_params[:tags].each { |user_tag| tag_list.push(user_tag) } if tags_params[:tags].present?

        if event.save
          event.save_tags(tag_list)
          render json: { event: event.as_json(include: [{ post: { include: [:tags] } }, :user, :join_users, :tags]), message: 'イベントを作成しました', status: :created }
        else
          render json: event.errors, status: :unprocessable_entity
        end
      end

      def update
        tag_list = []
        tags_params[:tags].each { |user_tag| tag_list.push(user_tag) } if tags_params[:tags].present?

        if @event.update(event_params)
          @event.save_tags(tag_list)
          render json: @event.as_json(include: [{ post: { include: [:tags] } }, :user, :join_users, :tags]), status: :ok
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

      def set_user
        @user = User.find(event_params[:user_id])
      end

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

      def tags_params
        params.require(:event).permit(tags: [])
      end
    end
  end
end
