class Api::V1::CommentsController < ApplicationController
  def create
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :reply_id, :content)
    end
end
