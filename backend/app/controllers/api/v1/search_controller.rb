class Api::V1::SearchController < ApplicationController
  def users
    users = User.where('name Like ? OR description Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    render json: users.as_json()
  end

  def posts
    unless params[:keyword].empty?
      posts = Post.where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    else
      posts = []
    end
    render json: posts.as_json(include: [{ user: { methods: :image_url } }, :liked_users, :tags])
  end

  def events
    events = Event.where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") unless params[:keyword].empty?

    render json: events.as_json()
  end

  def tags
    tags = Tag.where('name Like ?', "%#{params[:keyword]}%") unless params[:keyword].empty?
    render json: tags
  end
end
