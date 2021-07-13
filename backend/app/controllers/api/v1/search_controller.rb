class Api::V1::SearchController < ApplicationController
  def users
    users = User.where('name Like ? OR description Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword]
    render json: users
  end

  def posts
    posts = Post.where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword]
    render json: posts
  end

  def events
    events = Event.where('title Like ? OR content Like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword]
    render json: events
  end

  def tags
    tags = Tag.where('name Like ?', "%#{params[:keyword]}%")
    render json: tags
  end
end
