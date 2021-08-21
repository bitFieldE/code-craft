module Api
  module V1
    class TopController < ApplicationController
      def index
        posts = Post.joins(:likes).group(:id).order('count(likes.post_id) desc').limit(6)
        events = Event.where('scheduled_date > ? AND scheduled_date <= ?', Date.today, Date.today + 14.day).limit(6)
        render json: {
          posts: posts.as_json(include: %i[user liked_users tags]),
          events: events.as_json(include: %i[user post tags join_users])
        }
      end
    end
  end
end
