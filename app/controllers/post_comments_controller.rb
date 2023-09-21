class PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    # redirect_to post_path(post)
    @post = post
    @post_comment = PostComment.new
  end

  def destroy
    PostComment.find(params[:id]).destroy
    # redirect_to post_path(params[:post_id])
    @post = Post.find(params[:post_id])
    # @post_comment = PostComment.new
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
