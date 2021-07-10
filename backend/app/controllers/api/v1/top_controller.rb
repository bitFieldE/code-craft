module Api
  module V1
    class TopController < ApplicationController
      def index
        posts = Post.joins(:likes).group(:id).order('count(likes.post_id) desc').limit(6)
        events = Event.where('scheduled_date > ? AND scheduled_date <= ?', Date.today, Date.today + 7.day).limit(6)
        render json: {
          posts: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags]),
          events: events.as_json(include: [{ user: { methods: :image_url } }, :join_users], methods: :image_url)
        }
      end
    end
  end
end
