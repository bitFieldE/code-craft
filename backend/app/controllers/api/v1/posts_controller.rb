module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user, except: [:show]
      before_action :set_post, except: %i[index create]

      def index; end

      def show
        render json: @post.as_json(include: [{ user: { methods: :image_url } }, { comments: { include: { user: { methods: :image_url } }, methods: :created_date } }, :tags],
                                   methods: %i[images_data created_date])
      end

      def create
        post = Post.new(post_params)
        post.user = current_user
        # 投稿した画像の保存
        params[:images].each { |image| post.images.attach(image) } if params[:images].present?

        if post.save
          post.save_tags(tags_params[:tags])
          render json: { post: post.as_json(include: [{ user: { methods: :image_url } }, :tags, :comments], methods: [:images_data]),
                         message: '投稿を作成しました', status: :created }
        else
          render json: post.errors, status: :unprocessable_entity
        end
      end

      def update
        # 投稿した画像の保存
        params[:images].each { |image| post.images.attach(image) } if params[:images].present?
        if @post.update(post_params)
          @post.save_tags(tags_params[:tags])
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy; end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :content, :rate, images: [])
      end

      def tags_params
        params.require(:post).permit(tags: [])
      end
    end
  end
end
