module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user, except: [:show]
      before_action :set_post, except: %i[index create]

      def index; end

      def show
        render json: @post.as_json(include: [:tags, { user: { methods: :image_url } }], methods: [:images_data])
      end

      def create
        post = Post.new(post_params)
        post.user = current_user
        tag_list = []
        # 投稿した画像の保存
        params[:images].each { |image| post.images.attach(image) } if params[:images].present?
        # 記事のタグの保存
        tags_params[:tags].each { |post_tag| tag_list.push(post_tag) } if tags_params[:tags].present?

        if post.save
          post.save_tags(tag_list)
          render json: { post: post.as_json(include: [{ user: { methods: :image_url } }, :tags], methods: [:images_data]),
                         message: '投稿を作成しました', status: :created }
        else
          render json: post.errors, status: :unprocessable_entity
        end
      end

      def edit
        render json: @post
      end

      def update
        if @post.update(post_params)
          render json: post
        else
          render json: post.errors, status: :unprocessable_entity
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
