class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word]).page(params[:page])
    else
      @posts = Post.looks(params[:search], params[:word]).page(params[:page])
    end
  end

end
